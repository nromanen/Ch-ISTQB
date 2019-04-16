PGDMP         ,                w        
   Kukharchuk    11.2    11.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            �           1262    16572 
   Kukharchuk    DATABASE     �   CREATE DATABASE "Kukharchuk" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Ukrainian_Ukraine.1251' LC_CTYPE = 'Ukrainian_Ukraine.1251';
    DROP DATABASE "Kukharchuk";
             postgres    false                        2615    16573    pgagent    SCHEMA        CREATE SCHEMA pgagent;
    DROP SCHEMA pgagent;
             postgres    false            �           0    0    SCHEMA pgagent    COMMENT     6   COMMENT ON SCHEMA pgagent IS 'pgAgent system tables';
                  postgres    false    7                        3079    16574 	   adminpack 	   EXTENSION     A   CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;
    DROP EXTENSION adminpack;
                  false            �           0    0    EXTENSION adminpack    COMMENT     M   COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';
                       false    1            �            1255    16583    pga_exception_trigger()    FUNCTION       CREATE FUNCTION pgagent.pga_exception_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE

    v_jobid int4 := 0;

BEGIN

     IF TG_OP = 'DELETE' THEN

        SELECT INTO v_jobid jscjobid FROM pgagent.pga_schedule WHERE jscid = OLD.jexscid;

        -- update pga_job from remaining schedules
        -- the actual calculation of jobnextrun will be performed in the trigger
        UPDATE pgagent.pga_job
           SET jobnextrun = NULL
         WHERE jobenabled AND jobid = v_jobid;
        RETURN OLD;
    ELSE

        SELECT INTO v_jobid jscjobid FROM pgagent.pga_schedule WHERE jscid = NEW.jexscid;

        UPDATE pgagent.pga_job
           SET jobnextrun = NULL
         WHERE jobenabled AND jobid = v_jobid;
        RETURN NEW;
    END IF;
END;
$$;
 /   DROP FUNCTION pgagent.pga_exception_trigger();
       pgagent       postgres    false    7            �           0    0     FUNCTION pga_exception_trigger()    COMMENT     x   COMMENT ON FUNCTION pgagent.pga_exception_trigger() IS 'Update the job''s next run time whenever an exception changes';
            pgagent       postgres    false    226            �            1255    16584    pga_is_leap_year(smallint)    FUNCTION       CREATE FUNCTION pgagent.pga_is_leap_year(smallint) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $_$
BEGIN
    IF $1 % 4 != 0 THEN
        RETURN FALSE;
    END IF;

    IF $1 % 100 != 0 THEN
        RETURN TRUE;
    END IF;

    RETURN $1 % 400 = 0;
END;
$_$;
 2   DROP FUNCTION pgagent.pga_is_leap_year(smallint);
       pgagent       postgres    false    7            �           0    0 #   FUNCTION pga_is_leap_year(smallint)    COMMENT     _   COMMENT ON FUNCTION pgagent.pga_is_leap_year(smallint) IS 'Returns TRUE if $1 is a leap year';
            pgagent       postgres    false    227            �            1255    16585    pga_job_trigger()    FUNCTION       CREATE FUNCTION pgagent.pga_job_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF NEW.jobenabled THEN
        IF NEW.jobnextrun IS NULL THEN
             SELECT INTO NEW.jobnextrun
                    MIN(pgagent.pga_next_schedule(jscid, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths))
               FROM pgagent.pga_schedule
              WHERE jscenabled AND jscjobid=OLD.jobid;
        END IF;
    ELSE
        NEW.jobnextrun := NULL;
    END IF;
    RETURN NEW;
END;
$$;
 )   DROP FUNCTION pgagent.pga_job_trigger();
       pgagent       postgres    false    7            �           0    0    FUNCTION pga_job_trigger()    COMMENT     U   COMMENT ON FUNCTION pgagent.pga_job_trigger() IS 'Update the job''s next run time.';
            pgagent       postgres    false    240            �            1255    16586 �   pga_next_schedule(integer, timestamp with time zone, timestamp with time zone, boolean[], boolean[], boolean[], boolean[], boolean[])    FUNCTION     �8  CREATE FUNCTION pgagent.pga_next_schedule(integer, timestamp with time zone, timestamp with time zone, boolean[], boolean[], boolean[], boolean[], boolean[]) RETURNS timestamp with time zone
    LANGUAGE plpgsql
    AS $_$
DECLARE
    jscid           ALIAS FOR $1;
    jscstart        ALIAS FOR $2;
    jscend          ALIAS FOR $3;
    jscminutes      ALIAS FOR $4;
    jschours        ALIAS FOR $5;
    jscweekdays     ALIAS FOR $6;
    jscmonthdays    ALIAS FOR $7;
    jscmonths       ALIAS FOR $8;

    nextrun         timestamp := '1970-01-01 00:00:00-00';
    runafter        timestamp := '1970-01-01 00:00:00-00';

    bingo            bool := FALSE;
    gotit            bool := FALSE;
    foundval        bool := FALSE;
    daytweak        bool := FALSE;
    minutetweak        bool := FALSE;

    i                int2 := 0;
    d                int2 := 0;

    nextminute        int2 := 0;
    nexthour        int2 := 0;
    nextday            int2 := 0;
    nextmonth       int2 := 0;
    nextyear        int2 := 0;


BEGIN
    -- No valid start date has been specified
    IF jscstart IS NULL THEN RETURN NULL; END IF;

    -- The schedule is past its end date
    IF jscend IS NOT NULL AND jscend < now() THEN RETURN NULL; END IF;

    -- Get the time to find the next run after. It will just be the later of
    -- now() + 1m and the start date for the time being, however, we might want to
    -- do more complex things using this value in the future.
    IF date_trunc('MINUTE', jscstart) > date_trunc('MINUTE', (now() + '1 Minute'::interval)) THEN
        runafter := date_trunc('MINUTE', jscstart);
    ELSE
        runafter := date_trunc('MINUTE', (now() + '1 Minute'::interval));
    END IF;

    --
    -- Enter a loop, generating next run timestamps until we find one
    -- that falls on the required weekday, and is not matched by an exception
    --

    WHILE bingo = FALSE LOOP

        --
        -- Get the next run year
        --
        nextyear := date_part('YEAR', runafter);

        --
        -- Get the next run month
        --
        nextmonth := date_part('MONTH', runafter);
        gotit := FALSE;
        FOR i IN (nextmonth) .. 12 LOOP
            IF jscmonths[i] = TRUE THEN
                nextmonth := i;
                gotit := TRUE;
                foundval := TRUE;
                EXIT;
            END IF;
        END LOOP;
        IF gotit = FALSE THEN
            FOR i IN 1 .. (nextmonth - 1) LOOP
                IF jscmonths[i] = TRUE THEN
                    nextmonth := i;

                    -- Wrap into next year
                    nextyear := nextyear + 1;
                    gotit := TRUE;
                    foundval := TRUE;
                    EXIT;
                END IF;
           END LOOP;
        END IF;

        --
        -- Get the next run day
        --
        -- If the year, or month have incremented, get the lowest day,
        -- otherwise look for the next day matching or after today.
        IF (nextyear > date_part('YEAR', runafter) OR nextmonth > date_part('MONTH', runafter)) THEN
            nextday := 1;
            FOR i IN 1 .. 32 LOOP
                IF jscmonthdays[i] = TRUE THEN
                    nextday := i;
                    foundval := TRUE;
                    EXIT;
                END IF;
            END LOOP;
        ELSE
            nextday := date_part('DAY', runafter);
            gotit := FALSE;
            FOR i IN nextday .. 32 LOOP
                IF jscmonthdays[i] = TRUE THEN
                    nextday := i;
                    gotit := TRUE;
                    foundval := TRUE;
                    EXIT;
                END IF;
            END LOOP;
            IF gotit = FALSE THEN
                FOR i IN 1 .. (nextday - 1) LOOP
                    IF jscmonthdays[i] = TRUE THEN
                        nextday := i;

                        -- Wrap into next month
                        IF nextmonth = 12 THEN
                            nextyear := nextyear + 1;
                            nextmonth := 1;
                        ELSE
                            nextmonth := nextmonth + 1;
                        END IF;
                        gotit := TRUE;
                        foundval := TRUE;
                        EXIT;
                    END IF;
                END LOOP;
            END IF;
        END IF;

        -- Was the last day flag selected?
        IF nextday = 32 THEN
            IF nextmonth = 1 THEN
                nextday := 31;
            ELSIF nextmonth = 2 THEN
                IF pgagent.pga_is_leap_year(nextyear) = TRUE THEN
                    nextday := 29;
                ELSE
                    nextday := 28;
                END IF;
            ELSIF nextmonth = 3 THEN
                nextday := 31;
            ELSIF nextmonth = 4 THEN
                nextday := 30;
            ELSIF nextmonth = 5 THEN
                nextday := 31;
            ELSIF nextmonth = 6 THEN
                nextday := 30;
            ELSIF nextmonth = 7 THEN
                nextday := 31;
            ELSIF nextmonth = 8 THEN
                nextday := 31;
            ELSIF nextmonth = 9 THEN
                nextday := 30;
            ELSIF nextmonth = 10 THEN
                nextday := 31;
            ELSIF nextmonth = 11 THEN
                nextday := 30;
            ELSIF nextmonth = 12 THEN
                nextday := 31;
            END IF;
        END IF;

        --
        -- Get the next run hour
        --
        -- If the year, month or day have incremented, get the lowest hour,
        -- otherwise look for the next hour matching or after the current one.
        IF (nextyear > date_part('YEAR', runafter) OR nextmonth > date_part('MONTH', runafter) OR nextday > date_part('DAY', runafter) OR daytweak = TRUE) THEN
            nexthour := 0;
            FOR i IN 1 .. 24 LOOP
                IF jschours[i] = TRUE THEN
                    nexthour := i - 1;
                    foundval := TRUE;
                    EXIT;
                END IF;
            END LOOP;
        ELSE
            nexthour := date_part('HOUR', runafter);
            gotit := FALSE;
            FOR i IN (nexthour + 1) .. 24 LOOP
                IF jschours[i] = TRUE THEN
                    nexthour := i - 1;
                    gotit := TRUE;
                    foundval := TRUE;
                    EXIT;
                END IF;
            END LOOP;
            IF gotit = FALSE THEN
                FOR i IN 1 .. nexthour LOOP
                    IF jschours[i] = TRUE THEN
                        nexthour := i - 1;

                        -- Wrap into next month
                        IF (nextmonth = 1 OR nextmonth = 3 OR nextmonth = 5 OR nextmonth = 7 OR nextmonth = 8 OR nextmonth = 10 OR nextmonth = 12) THEN
                            d = 31;
                        ELSIF (nextmonth = 4 OR nextmonth = 6 OR nextmonth = 9 OR nextmonth = 11) THEN
                            d = 30;
                        ELSE
                            IF pgagent.pga_is_leap_year(nextyear) = TRUE THEN
                                d := 29;
                            ELSE
                                d := 28;
                            END IF;
                        END IF;

                        IF nextday = d THEN
                            nextday := 1;
                            IF nextmonth = 12 THEN
                                nextyear := nextyear + 1;
                                nextmonth := 1;
                            ELSE
                                nextmonth := nextmonth + 1;
                            END IF;
                        ELSE
                            nextday := nextday + 1;
                        END IF;

                        gotit := TRUE;
                        foundval := TRUE;
                        EXIT;
                    END IF;
                END LOOP;
            END IF;
        END IF;

        --
        -- Get the next run minute
        --
        -- If the year, month day or hour have incremented, get the lowest minute,
        -- otherwise look for the next minute matching or after the current one.
        IF (nextyear > date_part('YEAR', runafter) OR nextmonth > date_part('MONTH', runafter) OR nextday > date_part('DAY', runafter) OR nexthour > date_part('HOUR', runafter) OR daytweak = TRUE) THEN
            nextminute := 0;
            IF minutetweak = TRUE THEN
        d := 1;
            ELSE
        d := date_part('YEAR', runafter)::int2;
            END IF;
            FOR i IN d .. 60 LOOP
                IF jscminutes[i] = TRUE THEN
                    nextminute := i - 1;
                    foundval := TRUE;
                    EXIT;
                END IF;
            END LOOP;
        ELSE
            nextminute := date_part('MINUTE', runafter);
            gotit := FALSE;
            FOR i IN (nextminute + 1) .. 60 LOOP
                IF jscminutes[i] = TRUE THEN
                    nextminute := i - 1;
                    gotit := TRUE;
                    foundval := TRUE;
                    EXIT;
                END IF;
            END LOOP;
            IF gotit = FALSE THEN
                FOR i IN 1 .. nextminute LOOP
                    IF jscminutes[i] = TRUE THEN
                        nextminute := i - 1;

                        -- Wrap into next hour
                        IF (nextmonth = 1 OR nextmonth = 3 OR nextmonth = 5 OR nextmonth = 7 OR nextmonth = 8 OR nextmonth = 10 OR nextmonth = 12) THEN
                            d = 31;
                        ELSIF (nextmonth = 4 OR nextmonth = 6 OR nextmonth = 9 OR nextmonth = 11) THEN
                            d = 30;
                        ELSE
                            IF pgagent.pga_is_leap_year(nextyear) = TRUE THEN
                                d := 29;
                            ELSE
                                d := 28;
                            END IF;
                        END IF;

                        IF nexthour = 23 THEN
                            nexthour = 0;
                            IF nextday = d THEN
                                nextday := 1;
                                IF nextmonth = 12 THEN
                                    nextyear := nextyear + 1;
                                    nextmonth := 1;
                                ELSE
                                    nextmonth := nextmonth + 1;
                                END IF;
                            ELSE
                                nextday := nextday + 1;
                            END IF;
                        ELSE
                            nexthour := nexthour + 1;
                        END IF;

                        gotit := TRUE;
                        foundval := TRUE;
                        EXIT;
                    END IF;
                END LOOP;
            END IF;
        END IF;

        -- Build the result, and check it is not the same as runafter - this may
        -- happen if all array entries are set to false. In this case, add a minute.

        nextrun := (nextyear::varchar || '-'::varchar || nextmonth::varchar || '-' || nextday::varchar || ' ' || nexthour::varchar || ':' || nextminute::varchar)::timestamptz;

        IF nextrun = runafter AND foundval = FALSE THEN
                nextrun := nextrun + INTERVAL '1 Minute';
        END IF;

        -- If the result is past the end date, exit.
        IF nextrun > jscend THEN
            RETURN NULL;
        END IF;

        -- Check to ensure that the nextrun time is actually still valid. Its
        -- possible that wrapped values may have carried the nextrun onto an
        -- invalid time or date.
        IF ((jscminutes = '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}' OR jscminutes[date_part('MINUTE', nextrun) + 1] = TRUE) AND
            (jschours = '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}' OR jschours[date_part('HOUR', nextrun) + 1] = TRUE) AND
            (jscmonthdays = '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}' OR jscmonthdays[date_part('DAY', nextrun)] = TRUE OR
            (jscmonthdays = '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,t}' AND
             ((date_part('MONTH', nextrun) IN (1,3,5,7,8,10,12) AND date_part('DAY', nextrun) = 31) OR
              (date_part('MONTH', nextrun) IN (4,6,9,11) AND date_part('DAY', nextrun) = 30) OR
              (date_part('MONTH', nextrun) = 2 AND ((pgagent.pga_is_leap_year(date_part('DAY', nextrun)::int2) AND date_part('DAY', nextrun) = 29) OR date_part('DAY', nextrun) = 28))))) AND
            (jscmonths = '{f,f,f,f,f,f,f,f,f,f,f,f}' OR jscmonths[date_part('MONTH', nextrun)] = TRUE)) THEN


            -- Now, check to see if the nextrun time found is a) on an acceptable
            -- weekday, and b) not matched by an exception. If not, set
            -- runafter = nextrun and try again.

            -- Check for a wildcard weekday
            gotit := FALSE;
            FOR i IN 1 .. 7 LOOP
                IF jscweekdays[i] = TRUE THEN
                    gotit := TRUE;
                    EXIT;
                END IF;
            END LOOP;

            -- OK, is the correct weekday selected, or a wildcard?
            IF (jscweekdays[date_part('DOW', nextrun) + 1] = TRUE OR gotit = FALSE) THEN

                -- Check for exceptions
                SELECT INTO d jexid FROM pgagent.pga_exception WHERE jexscid = jscid AND ((jexdate = nextrun::date AND jextime = nextrun::time) OR (jexdate = nextrun::date AND jextime IS NULL) OR (jexdate IS NULL AND jextime = nextrun::time));
                IF FOUND THEN
                    -- Nuts - found an exception. Increment the time and try again
                    runafter := nextrun + INTERVAL '1 Minute';
                    bingo := FALSE;
                    minutetweak := TRUE;
            daytweak := FALSE;
                ELSE
                    bingo := TRUE;
                END IF;
            ELSE
                -- We're on the wrong week day - increment a day and try again.
                runafter := nextrun + INTERVAL '1 Day';
                bingo := FALSE;
                minutetweak := FALSE;
                daytweak := TRUE;
            END IF;

        ELSE
            runafter := nextrun + INTERVAL '1 Minute';
            bingo := FALSE;
            minutetweak := TRUE;
        daytweak := FALSE;
        END IF;

    END LOOP;

    RETURN nextrun;
END;
$_$;
 �   DROP FUNCTION pgagent.pga_next_schedule(integer, timestamp with time zone, timestamp with time zone, boolean[], boolean[], boolean[], boolean[], boolean[]);
       pgagent       postgres    false    7            �           0    0 �   FUNCTION pga_next_schedule(integer, timestamp with time zone, timestamp with time zone, boolean[], boolean[], boolean[], boolean[], boolean[])    COMMENT     �   COMMENT ON FUNCTION pgagent.pga_next_schedule(integer, timestamp with time zone, timestamp with time zone, boolean[], boolean[], boolean[], boolean[], boolean[]) IS 'Calculates the next runtime for a given schedule';
            pgagent       postgres    false    241            �            1255    16588    pga_schedule_trigger()    FUNCTION     /  CREATE FUNCTION pgagent.pga_schedule_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        -- update pga_job from remaining schedules
        -- the actual calculation of jobnextrun will be performed in the trigger
        UPDATE pgagent.pga_job
           SET jobnextrun = NULL
         WHERE jobenabled AND jobid=OLD.jscjobid;
        RETURN OLD;
    ELSE
        UPDATE pgagent.pga_job
           SET jobnextrun = NULL
         WHERE jobenabled AND jobid=NEW.jscjobid;
        RETURN NEW;
    END IF;
END;
$$;
 .   DROP FUNCTION pgagent.pga_schedule_trigger();
       pgagent       postgres    false    7            �           0    0    FUNCTION pga_schedule_trigger()    COMMENT     u   COMMENT ON FUNCTION pgagent.pga_schedule_trigger() IS 'Update the job''s next run time whenever a schedule changes';
            pgagent       postgres    false    242            �            1255    16589    pgagent_schema_version()    FUNCTION     �   CREATE FUNCTION pgagent.pgagent_schema_version() RETURNS smallint
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- RETURNS PGAGENT MAJOR VERSION
    -- WE WILL CHANGE THE MAJOR VERSION, ONLY IF THERE IS A SCHEMA CHANGE
    RETURN 3;
END;
$$;
 0   DROP FUNCTION pgagent.pgagent_schema_version();
       pgagent       postgres    false    7            �            1259    16590    pga_exception    TABLE     �   CREATE TABLE pgagent.pga_exception (
    jexid integer NOT NULL,
    jexscid integer NOT NULL,
    jexdate date,
    jextime time without time zone
);
 "   DROP TABLE pgagent.pga_exception;
       pgagent         postgres    false    7            �            1259    16593    pga_exception_jexid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_exception_jexid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE pgagent.pga_exception_jexid_seq;
       pgagent       postgres    false    198    7            �           0    0    pga_exception_jexid_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE pgagent.pga_exception_jexid_seq OWNED BY pgagent.pga_exception.jexid;
            pgagent       postgres    false    199            �            1259    16595    pga_job    TABLE       CREATE TABLE pgagent.pga_job (
    jobid integer NOT NULL,
    jobjclid integer NOT NULL,
    jobname text NOT NULL,
    jobdesc text DEFAULT ''::text NOT NULL,
    jobhostagent text DEFAULT ''::text NOT NULL,
    jobenabled boolean DEFAULT true NOT NULL,
    jobcreated timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    jobchanged timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    jobagentid integer,
    jobnextrun timestamp with time zone,
    joblastrun timestamp with time zone
);
    DROP TABLE pgagent.pga_job;
       pgagent         postgres    false    7            �           0    0    TABLE pga_job    COMMENT     6   COMMENT ON TABLE pgagent.pga_job IS 'Job main entry';
            pgagent       postgres    false    200            �           0    0    COLUMN pga_job.jobagentid    COMMENT     [   COMMENT ON COLUMN pgagent.pga_job.jobagentid IS 'Agent that currently executes this job.';
            pgagent       postgres    false    200            �            1259    16606    pga_job_jobid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_job_jobid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE pgagent.pga_job_jobid_seq;
       pgagent       postgres    false    7    200            �           0    0    pga_job_jobid_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE pgagent.pga_job_jobid_seq OWNED BY pgagent.pga_job.jobid;
            pgagent       postgres    false    201            �            1259    16608    pga_jobagent    TABLE     �   CREATE TABLE pgagent.pga_jobagent (
    jagpid integer NOT NULL,
    jaglogintime timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    jagstation text NOT NULL
);
 !   DROP TABLE pgagent.pga_jobagent;
       pgagent         postgres    false    7            �           0    0    TABLE pga_jobagent    COMMENT     >   COMMENT ON TABLE pgagent.pga_jobagent IS 'Active job agents';
            pgagent       postgres    false    202            �            1259    16615    pga_jobclass    TABLE     ]   CREATE TABLE pgagent.pga_jobclass (
    jclid integer NOT NULL,
    jclname text NOT NULL
);
 !   DROP TABLE pgagent.pga_jobclass;
       pgagent         postgres    false    7            �           0    0    TABLE pga_jobclass    COMMENT     ?   COMMENT ON TABLE pgagent.pga_jobclass IS 'Job classification';
            pgagent       postgres    false    203            �            1259    16621    pga_jobclass_jclid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_jobclass_jclid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE pgagent.pga_jobclass_jclid_seq;
       pgagent       postgres    false    7    203            �           0    0    pga_jobclass_jclid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE pgagent.pga_jobclass_jclid_seq OWNED BY pgagent.pga_jobclass.jclid;
            pgagent       postgres    false    204            �            1259    16623 
   pga_joblog    TABLE     �  CREATE TABLE pgagent.pga_joblog (
    jlgid integer NOT NULL,
    jlgjobid integer NOT NULL,
    jlgstatus character(1) DEFAULT 'r'::bpchar NOT NULL,
    jlgstart timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    jlgduration interval,
    CONSTRAINT pga_joblog_jlgstatus_check CHECK ((jlgstatus = ANY (ARRAY['r'::bpchar, 's'::bpchar, 'f'::bpchar, 'i'::bpchar, 'd'::bpchar])))
);
    DROP TABLE pgagent.pga_joblog;
       pgagent         postgres    false    7            �           0    0    TABLE pga_joblog    COMMENT     8   COMMENT ON TABLE pgagent.pga_joblog IS 'Job run logs.';
            pgagent       postgres    false    205            �           0    0    COLUMN pga_joblog.jlgstatus    COMMENT     �   COMMENT ON COLUMN pgagent.pga_joblog.jlgstatus IS 'Status of job: r=running, s=successfully finished, f=failed, i=no steps to execute, d=aborted';
            pgagent       postgres    false    205            �            1259    16629    pga_joblog_jlgid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_joblog_jlgid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE pgagent.pga_joblog_jlgid_seq;
       pgagent       postgres    false    205    7            �           0    0    pga_joblog_jlgid_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE pgagent.pga_joblog_jlgid_seq OWNED BY pgagent.pga_joblog.jlgid;
            pgagent       postgres    false    206            �            1259    16631    pga_jobstep    TABLE        CREATE TABLE pgagent.pga_jobstep (
    jstid integer NOT NULL,
    jstjobid integer NOT NULL,
    jstname text NOT NULL,
    jstdesc text DEFAULT ''::text NOT NULL,
    jstenabled boolean DEFAULT true NOT NULL,
    jstkind character(1) NOT NULL,
    jstcode text NOT NULL,
    jstconnstr text DEFAULT ''::text NOT NULL,
    jstdbname name DEFAULT ''::name NOT NULL,
    jstonerror character(1) DEFAULT 'f'::bpchar NOT NULL,
    jscnextrun timestamp with time zone,
    CONSTRAINT pga_jobstep_check CHECK ((((jstconnstr <> ''::text) AND (jstkind = 's'::bpchar)) OR ((jstconnstr = ''::text) AND ((jstkind = 'b'::bpchar) OR (jstdbname <> ''::name))))),
    CONSTRAINT pga_jobstep_check1 CHECK ((((jstdbname <> ''::name) AND (jstkind = 's'::bpchar)) OR ((jstdbname = ''::name) AND ((jstkind = 'b'::bpchar) OR (jstconnstr <> ''::text))))),
    CONSTRAINT pga_jobstep_jstkind_check CHECK ((jstkind = ANY (ARRAY['b'::bpchar, 's'::bpchar]))),
    CONSTRAINT pga_jobstep_jstonerror_check CHECK ((jstonerror = ANY (ARRAY['f'::bpchar, 's'::bpchar, 'i'::bpchar])))
);
     DROP TABLE pgagent.pga_jobstep;
       pgagent         postgres    false    7            �           0    0    TABLE pga_jobstep    COMMENT     C   COMMENT ON TABLE pgagent.pga_jobstep IS 'Job step to be executed';
            pgagent       postgres    false    207            �           0    0    COLUMN pga_jobstep.jstkind    COMMENT     T   COMMENT ON COLUMN pgagent.pga_jobstep.jstkind IS 'Kind of jobstep: s=sql, b=batch';
            pgagent       postgres    false    207            �           0    0    COLUMN pga_jobstep.jstonerror    COMMENT     �   COMMENT ON COLUMN pgagent.pga_jobstep.jstonerror IS 'What to do if step returns an error: f=fail the job, s=mark step as succeeded and continue, i=mark as fail but ignore it and proceed';
            pgagent       postgres    false    207            �            1259    16646    pga_jobstep_jstid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_jobstep_jstid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE pgagent.pga_jobstep_jstid_seq;
       pgagent       postgres    false    207    7            �           0    0    pga_jobstep_jstid_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE pgagent.pga_jobstep_jstid_seq OWNED BY pgagent.pga_jobstep.jstid;
            pgagent       postgres    false    208            �            1259    16648    pga_jobsteplog    TABLE     �  CREATE TABLE pgagent.pga_jobsteplog (
    jslid integer NOT NULL,
    jsljlgid integer NOT NULL,
    jsljstid integer NOT NULL,
    jslstatus character(1) DEFAULT 'r'::bpchar NOT NULL,
    jslresult integer,
    jslstart timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    jslduration interval,
    jsloutput text,
    CONSTRAINT pga_jobsteplog_jslstatus_check CHECK ((jslstatus = ANY (ARRAY['r'::bpchar, 's'::bpchar, 'i'::bpchar, 'f'::bpchar, 'd'::bpchar])))
);
 #   DROP TABLE pgagent.pga_jobsteplog;
       pgagent         postgres    false    7            �           0    0    TABLE pga_jobsteplog    COMMENT     A   COMMENT ON TABLE pgagent.pga_jobsteplog IS 'Job step run logs.';
            pgagent       postgres    false    209            �           0    0    COLUMN pga_jobsteplog.jslstatus    COMMENT     �   COMMENT ON COLUMN pgagent.pga_jobsteplog.jslstatus IS 'Status of job step: r=running, s=successfully finished,  f=failed stopping job, i=ignored failure, d=aborted';
            pgagent       postgres    false    209            �           0    0    COLUMN pga_jobsteplog.jslresult    COMMENT     Q   COMMENT ON COLUMN pgagent.pga_jobsteplog.jslresult IS 'Return code of job step';
            pgagent       postgres    false    209            �            1259    16657    pga_jobsteplog_jslid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_jobsteplog_jslid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE pgagent.pga_jobsteplog_jslid_seq;
       pgagent       postgres    false    7    209                        0    0    pga_jobsteplog_jslid_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE pgagent.pga_jobsteplog_jslid_seq OWNED BY pgagent.pga_jobsteplog.jslid;
            pgagent       postgres    false    210            �            1259    16659    pga_schedule    TABLE     '  CREATE TABLE pgagent.pga_schedule (
    jscid integer NOT NULL,
    jscjobid integer NOT NULL,
    jscname text NOT NULL,
    jscdesc text DEFAULT ''::text NOT NULL,
    jscenabled boolean DEFAULT true NOT NULL,
    jscstart timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    jscend timestamp with time zone,
    jscminutes boolean[] DEFAULT '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[] NOT NULL,
    jschours boolean[] DEFAULT '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[] NOT NULL,
    jscweekdays boolean[] DEFAULT '{f,f,f,f,f,f,f}'::boolean[] NOT NULL,
    jscmonthdays boolean[] DEFAULT '{f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[] NOT NULL,
    jscmonths boolean[] DEFAULT '{f,f,f,f,f,f,f,f,f,f,f,f}'::boolean[] NOT NULL,
    CONSTRAINT pga_schedule_jschours_size CHECK ((array_upper(jschours, 1) = 24)),
    CONSTRAINT pga_schedule_jscminutes_size CHECK ((array_upper(jscminutes, 1) = 60)),
    CONSTRAINT pga_schedule_jscmonthdays_size CHECK ((array_upper(jscmonthdays, 1) = 32)),
    CONSTRAINT pga_schedule_jscmonths_size CHECK ((array_upper(jscmonths, 1) = 12)),
    CONSTRAINT pga_schedule_jscweekdays_size CHECK ((array_upper(jscweekdays, 1) = 7))
);
 !   DROP TABLE pgagent.pga_schedule;
       pgagent         postgres    false    7                       0    0    TABLE pga_schedule    COMMENT     D   COMMENT ON TABLE pgagent.pga_schedule IS 'Job schedule exceptions';
            pgagent       postgres    false    211            �            1259    16678    pga_schedule_jscid_seq    SEQUENCE     �   CREATE SEQUENCE pgagent.pga_schedule_jscid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 .   DROP SEQUENCE pgagent.pga_schedule_jscid_seq;
       pgagent       postgres    false    7    211                       0    0    pga_schedule_jscid_seq    SEQUENCE OWNED BY     S   ALTER SEQUENCE pgagent.pga_schedule_jscid_seq OWNED BY pgagent.pga_schedule.jscid;
            pgagent       postgres    false    212            �            1259    16680    club    TABLE     �   CREATE TABLE public.club (
    city text,
    created date,
    trof integer,
    budget integer,
    president text,
    id integer NOT NULL,
    name integer,
    country integer,
    liga integer,
    stadium integer
);
    DROP TABLE public.club;
       public         postgres    false            �            1259    16808    club_id_seq    SEQUENCE     �   CREATE SEQUENCE public.club_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.club_id_seq;
       public       postgres    false    213                       0    0    club_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.club_id_seq OWNED BY public.club.id;
            public       postgres    false    218            �            1259    16692 
   count_trof    TABLE     �   CREATE TABLE public.count_trof (
    trof integer,
    name_club integer,
    year integer NOT NULL,
    id integer NOT NULL
);
    DROP TABLE public.count_trof;
       public         postgres    false            �            1259    16963    count_trof_id_seq    SEQUENCE     �   CREATE SEQUENCE public.count_trof_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.count_trof_id_seq;
       public       postgres    false    215                       0    0    count_trof_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.count_trof_id_seq OWNED BY public.count_trof.id;
            public       postgres    false    225            �            1259    16869    country    TABLE     P   CREATE TABLE public.country (
    name text,
    country_id integer NOT NULL
);
    DROP TABLE public.country;
       public         postgres    false            �            1259    16875    country_country_id_seq    SEQUENCE     �   CREATE SEQUENCE public.country_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 -   DROP SEQUENCE public.country_country_id_seq;
       public       postgres    false    220                       0    0    country_country_id_seq    SEQUENCE OWNED BY     Q   ALTER SEQUENCE public.country_country_id_seq OWNED BY public.country.country_id;
            public       postgres    false    221            �            1259    16686    liga    TABLE     �   CREATE TABLE public.liga (
    name text NOT NULL,
    rating integer,
    name_president text,
    liga_id integer NOT NULL,
    country_id integer
);
    DROP TABLE public.liga;
       public         postgres    false            �            1259    16849    liga_liga_id_seq    SEQUENCE     �   CREATE SEQUENCE public.liga_liga_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.liga_liga_id_seq;
       public       postgres    false    214                       0    0    liga_liga_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.liga_liga_id_seq OWNED BY public.liga.liga_id;
            public       postgres    false    219            �            1259    16935 	   name_club    TABLE     J   CREATE TABLE public.name_club (
    id integer NOT NULL,
    name text
);
    DROP TABLE public.name_club;
       public         postgres    false            �            1259    16938    name_club_id_seq    SEQUENCE     �   CREATE SEQUENCE public.name_club_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.name_club_id_seq;
       public       postgres    false    223                       0    0    name_club_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.name_club_id_seq OWNED BY public.name_club.id;
            public       postgres    false    224            �            1259    16698    stadium    TABLE     w   CREATE TABLE public.stadium (
    name text NOT NULL,
    created date,
    volume integer,
    id integer NOT NULL
);
    DROP TABLE public.stadium;
       public         postgres    false            �            1259    16886    stadium_id_seq    SEQUENCE     �   CREATE SEQUENCE public.stadium_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.stadium_id_seq;
       public       postgres    false    216                       0    0    stadium_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.stadium_id_seq OWNED BY public.stadium.id;
            public       postgres    false    222            �            1259    16704    trof    TABLE     W   CREATE TABLE public.trof (
    name text,
    created date,
    id integer NOT NULL
);
    DROP TABLE public.trof;
       public         postgres    false            �
           2604    16710    pga_exception jexid    DEFAULT     |   ALTER TABLE ONLY pgagent.pga_exception ALTER COLUMN jexid SET DEFAULT nextval('pgagent.pga_exception_jexid_seq'::regclass);
 C   ALTER TABLE pgagent.pga_exception ALTER COLUMN jexid DROP DEFAULT;
       pgagent       postgres    false    199    198            �
           2604    16711    pga_job jobid    DEFAULT     p   ALTER TABLE ONLY pgagent.pga_job ALTER COLUMN jobid SET DEFAULT nextval('pgagent.pga_job_jobid_seq'::regclass);
 =   ALTER TABLE pgagent.pga_job ALTER COLUMN jobid DROP DEFAULT;
       pgagent       postgres    false    201    200            �
           2604    16712    pga_jobclass jclid    DEFAULT     z   ALTER TABLE ONLY pgagent.pga_jobclass ALTER COLUMN jclid SET DEFAULT nextval('pgagent.pga_jobclass_jclid_seq'::regclass);
 B   ALTER TABLE pgagent.pga_jobclass ALTER COLUMN jclid DROP DEFAULT;
       pgagent       postgres    false    204    203            �
           2604    16713    pga_joblog jlgid    DEFAULT     v   ALTER TABLE ONLY pgagent.pga_joblog ALTER COLUMN jlgid SET DEFAULT nextval('pgagent.pga_joblog_jlgid_seq'::regclass);
 @   ALTER TABLE pgagent.pga_joblog ALTER COLUMN jlgid DROP DEFAULT;
       pgagent       postgres    false    206    205            �
           2604    16714    pga_jobstep jstid    DEFAULT     x   ALTER TABLE ONLY pgagent.pga_jobstep ALTER COLUMN jstid SET DEFAULT nextval('pgagent.pga_jobstep_jstid_seq'::regclass);
 A   ALTER TABLE pgagent.pga_jobstep ALTER COLUMN jstid DROP DEFAULT;
       pgagent       postgres    false    208    207            �
           2604    16715    pga_jobsteplog jslid    DEFAULT     ~   ALTER TABLE ONLY pgagent.pga_jobsteplog ALTER COLUMN jslid SET DEFAULT nextval('pgagent.pga_jobsteplog_jslid_seq'::regclass);
 D   ALTER TABLE pgagent.pga_jobsteplog ALTER COLUMN jslid DROP DEFAULT;
       pgagent       postgres    false    210    209                       2604    16716    pga_schedule jscid    DEFAULT     z   ALTER TABLE ONLY pgagent.pga_schedule ALTER COLUMN jscid SET DEFAULT nextval('pgagent.pga_schedule_jscid_seq'::regclass);
 B   ALTER TABLE pgagent.pga_schedule ALTER COLUMN jscid DROP DEFAULT;
       pgagent       postgres    false    212    211            
           2604    16810    club id    DEFAULT     b   ALTER TABLE ONLY public.club ALTER COLUMN id SET DEFAULT nextval('public.club_id_seq'::regclass);
 6   ALTER TABLE public.club ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    218    213                       2604    16965    count_trof id    DEFAULT     n   ALTER TABLE ONLY public.count_trof ALTER COLUMN id SET DEFAULT nextval('public.count_trof_id_seq'::regclass);
 <   ALTER TABLE public.count_trof ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    225    215                       2604    16877    country country_id    DEFAULT     x   ALTER TABLE ONLY public.country ALTER COLUMN country_id SET DEFAULT nextval('public.country_country_id_seq'::regclass);
 A   ALTER TABLE public.country ALTER COLUMN country_id DROP DEFAULT;
       public       postgres    false    221    220                       2604    16851    liga liga_id    DEFAULT     l   ALTER TABLE ONLY public.liga ALTER COLUMN liga_id SET DEFAULT nextval('public.liga_liga_id_seq'::regclass);
 ;   ALTER TABLE public.liga ALTER COLUMN liga_id DROP DEFAULT;
       public       postgres    false    219    214                       2604    16940    name_club id    DEFAULT     l   ALTER TABLE ONLY public.name_club ALTER COLUMN id SET DEFAULT nextval('public.name_club_id_seq'::regclass);
 ;   ALTER TABLE public.name_club ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    224    223                       2604    16888 
   stadium id    DEFAULT     h   ALTER TABLE ONLY public.stadium ALTER COLUMN id SET DEFAULT nextval('public.stadium_id_seq'::regclass);
 9   ALTER TABLE public.stadium ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    222    216            �          0    16590    pga_exception 
   TABLE DATA               J   COPY pgagent.pga_exception (jexid, jexscid, jexdate, jextime) FROM stdin;
    pgagent       postgres    false    198   ��       �          0    16595    pga_job 
   TABLE DATA               �   COPY pgagent.pga_job (jobid, jobjclid, jobname, jobdesc, jobhostagent, jobenabled, jobcreated, jobchanged, jobagentid, jobnextrun, joblastrun) FROM stdin;
    pgagent       postgres    false    200   ��       �          0    16608    pga_jobagent 
   TABLE DATA               I   COPY pgagent.pga_jobagent (jagpid, jaglogintime, jagstation) FROM stdin;
    pgagent       postgres    false    202   �       �          0    16615    pga_jobclass 
   TABLE DATA               7   COPY pgagent.pga_jobclass (jclid, jclname) FROM stdin;
    pgagent       postgres    false    203   S�       �          0    16623 
   pga_joblog 
   TABLE DATA               X   COPY pgagent.pga_joblog (jlgid, jlgjobid, jlgstatus, jlgstart, jlgduration) FROM stdin;
    pgagent       postgres    false    205   ��       �          0    16631    pga_jobstep 
   TABLE DATA               �   COPY pgagent.pga_jobstep (jstid, jstjobid, jstname, jstdesc, jstenabled, jstkind, jstcode, jstconnstr, jstdbname, jstonerror, jscnextrun) FROM stdin;
    pgagent       postgres    false    207   ��       �          0    16648    pga_jobsteplog 
   TABLE DATA               |   COPY pgagent.pga_jobsteplog (jslid, jsljlgid, jsljstid, jslstatus, jslresult, jslstart, jslduration, jsloutput) FROM stdin;
    pgagent       postgres    false    209   ��       �          0    16659    pga_schedule 
   TABLE DATA               �   COPY pgagent.pga_schedule (jscid, jscjobid, jscname, jscdesc, jscenabled, jscstart, jscend, jscminutes, jschours, jscweekdays, jscmonthdays, jscmonths) FROM stdin;
    pgagent       postgres    false    211          �          0    16680    club 
   TABLE DATA               h   COPY public.club (city, created, trof, budget, president, id, name, country, liga, stadium) FROM stdin;
    public       postgres    false    213   /       �          0    16692 
   count_trof 
   TABLE DATA               ?   COPY public.count_trof (trof, name_club, year, id) FROM stdin;
    public       postgres    false    215   �       �          0    16869    country 
   TABLE DATA               3   COPY public.country (name, country_id) FROM stdin;
    public       postgres    false    220   �      �          0    16686    liga 
   TABLE DATA               Q   COPY public.liga (name, rating, name_president, liga_id, country_id) FROM stdin;
    public       postgres    false    214   K      �          0    16935 	   name_club 
   TABLE DATA               -   COPY public.name_club (id, name) FROM stdin;
    public       postgres    false    223   �      �          0    16698    stadium 
   TABLE DATA               <   COPY public.stadium (name, created, volume, id) FROM stdin;
    public       postgres    false    216   �      �          0    16704    trof 
   TABLE DATA               1   COPY public.trof (name, created, id) FROM stdin;
    public       postgres    false    217   �      	           0    0    pga_exception_jexid_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('pgagent.pga_exception_jexid_seq', 1, false);
            pgagent       postgres    false    199            
           0    0    pga_job_jobid_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('pgagent.pga_job_jobid_seq', 1, false);
            pgagent       postgres    false    201                       0    0    pga_jobclass_jclid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('pgagent.pga_jobclass_jclid_seq', 5, true);
            pgagent       postgres    false    204                       0    0    pga_joblog_jlgid_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('pgagent.pga_joblog_jlgid_seq', 1, false);
            pgagent       postgres    false    206                       0    0    pga_jobstep_jstid_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('pgagent.pga_jobstep_jstid_seq', 1, false);
            pgagent       postgres    false    208                       0    0    pga_jobsteplog_jslid_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('pgagent.pga_jobsteplog_jslid_seq', 1, false);
            pgagent       postgres    false    210                       0    0    pga_schedule_jscid_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('pgagent.pga_schedule_jscid_seq', 1, false);
            pgagent       postgres    false    212                       0    0    club_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.club_id_seq', 4, true);
            public       postgres    false    218                       0    0    count_trof_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.count_trof_id_seq', 63, true);
            public       postgres    false    225                       0    0    country_country_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.country_country_id_seq', 11, true);
            public       postgres    false    221                       0    0    liga_liga_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public.liga_liga_id_seq', 5, true);
            public       postgres    false    219                       0    0    name_club_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.name_club_id_seq', 18, true);
            public       postgres    false    224                       0    0    stadium_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.stadium_id_seq', 10, true);
            public       postgres    false    222                       2606    16718     pga_exception pga_exception_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY pgagent.pga_exception
    ADD CONSTRAINT pga_exception_pkey PRIMARY KEY (jexid);
 K   ALTER TABLE ONLY pgagent.pga_exception DROP CONSTRAINT pga_exception_pkey;
       pgagent         postgres    false    198                       2606    16720    pga_job pga_job_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY pgagent.pga_job
    ADD CONSTRAINT pga_job_pkey PRIMARY KEY (jobid);
 ?   ALTER TABLE ONLY pgagent.pga_job DROP CONSTRAINT pga_job_pkey;
       pgagent         postgres    false    200                       2606    16722    pga_jobagent pga_jobagent_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY pgagent.pga_jobagent
    ADD CONSTRAINT pga_jobagent_pkey PRIMARY KEY (jagpid);
 I   ALTER TABLE ONLY pgagent.pga_jobagent DROP CONSTRAINT pga_jobagent_pkey;
       pgagent         postgres    false    202                       2606    16724    pga_jobclass pga_jobclass_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY pgagent.pga_jobclass
    ADD CONSTRAINT pga_jobclass_pkey PRIMARY KEY (jclid);
 I   ALTER TABLE ONLY pgagent.pga_jobclass DROP CONSTRAINT pga_jobclass_pkey;
       pgagent         postgres    false    203                       2606    16726    pga_joblog pga_joblog_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY pgagent.pga_joblog
    ADD CONSTRAINT pga_joblog_pkey PRIMARY KEY (jlgid);
 E   ALTER TABLE ONLY pgagent.pga_joblog DROP CONSTRAINT pga_joblog_pkey;
       pgagent         postgres    false    205                        2606    16728    pga_jobstep pga_jobstep_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY pgagent.pga_jobstep
    ADD CONSTRAINT pga_jobstep_pkey PRIMARY KEY (jstid);
 G   ALTER TABLE ONLY pgagent.pga_jobstep DROP CONSTRAINT pga_jobstep_pkey;
       pgagent         postgres    false    207            #           2606    16730 "   pga_jobsteplog pga_jobsteplog_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY pgagent.pga_jobsteplog
    ADD CONSTRAINT pga_jobsteplog_pkey PRIMARY KEY (jslid);
 M   ALTER TABLE ONLY pgagent.pga_jobsteplog DROP CONSTRAINT pga_jobsteplog_pkey;
       pgagent         postgres    false    209            &           2606    16732    pga_schedule pga_schedule_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY pgagent.pga_schedule
    ADD CONSTRAINT pga_schedule_pkey PRIMARY KEY (jscid);
 I   ALTER TABLE ONLY pgagent.pga_schedule DROP CONSTRAINT pga_schedule_pkey;
       pgagent         postgres    false    211            (           2606    16818    club club_id 
   CONSTRAINT     J   ALTER TABLE ONLY public.club
    ADD CONSTRAINT club_id PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.club DROP CONSTRAINT club_id;
       public         postgres    false    213            8           2606    16885    country country_id 
   CONSTRAINT     X   ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_id PRIMARY KEY (country_id);
 <   ALTER TABLE ONLY public.country DROP CONSTRAINT country_id;
       public         postgres    false    220            :           2606    16948    name_club id 
   CONSTRAINT     J   ALTER TABLE ONLY public.name_club
    ADD CONSTRAINT id PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.name_club DROP CONSTRAINT id;
       public         postgres    false    223            2           2606    16974    count_trof idkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.count_trof
    ADD CONSTRAINT idkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.count_trof DROP CONSTRAINT idkey;
       public         postgres    false    215            .           2606    16982    liga liga_id 
   CONSTRAINT     O   ALTER TABLE ONLY public.liga
    ADD CONSTRAINT liga_id PRIMARY KEY (liga_id);
 6   ALTER TABLE ONLY public.liga DROP CONSTRAINT liga_id;
       public         postgres    false    214            4           2606    16896    stadium stadium_id 
   CONSTRAINT     P   ALTER TABLE ONLY public.stadium
    ADD CONSTRAINT stadium_id PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.stadium DROP CONSTRAINT stadium_id;
       public         postgres    false    216            6           2606    16793    trof trof_id 
   CONSTRAINT     J   ALTER TABLE ONLY public.trof
    ADD CONSTRAINT trof_id PRIMARY KEY (id);
 6   ALTER TABLE ONLY public.trof DROP CONSTRAINT trof_id;
       public         postgres    false    217                       1259    16733    pga_exception_datetime    INDEX     d   CREATE UNIQUE INDEX pga_exception_datetime ON pgagent.pga_exception USING btree (jexdate, jextime);
 +   DROP INDEX pgagent.pga_exception_datetime;
       pgagent         postgres    false    198    198                       1259    16734    pga_exception_jexscid    INDEX     S   CREATE INDEX pga_exception_jexscid ON pgagent.pga_exception USING btree (jexscid);
 *   DROP INDEX pgagent.pga_exception_jexscid;
       pgagent         postgres    false    198                       1259    16735    pga_jobclass_name    INDEX     U   CREATE UNIQUE INDEX pga_jobclass_name ON pgagent.pga_jobclass USING btree (jclname);
 &   DROP INDEX pgagent.pga_jobclass_name;
       pgagent         postgres    false    203                       1259    16736    pga_joblog_jobid    INDEX     L   CREATE INDEX pga_joblog_jobid ON pgagent.pga_joblog USING btree (jlgjobid);
 %   DROP INDEX pgagent.pga_joblog_jobid;
       pgagent         postgres    false    205            $           1259    16737    pga_jobschedule_jobid    INDEX     S   CREATE INDEX pga_jobschedule_jobid ON pgagent.pga_schedule USING btree (jscjobid);
 *   DROP INDEX pgagent.pga_jobschedule_jobid;
       pgagent         postgres    false    211                       1259    16738    pga_jobstep_jobid    INDEX     N   CREATE INDEX pga_jobstep_jobid ON pgagent.pga_jobstep USING btree (jstjobid);
 &   DROP INDEX pgagent.pga_jobstep_jobid;
       pgagent         postgres    false    207            !           1259    16739    pga_jobsteplog_jslid    INDEX     T   CREATE INDEX pga_jobsteplog_jslid ON pgagent.pga_jobsteplog USING btree (jsljlgid);
 )   DROP INDEX pgagent.pga_jobsteplog_jslid;
       pgagent         postgres    false    209            )           1259    16980    fki_country    INDEX     ?   CREATE INDEX fki_country ON public.club USING btree (country);
    DROP INDEX public.fki_country;
       public         postgres    false    213            *           1259    16988    fki_liga    INDEX     9   CREATE INDEX fki_liga ON public.club USING btree (liga);
    DROP INDEX public.fki_liga;
       public         postgres    false    213            +           1259    16994    fki_name    INDEX     9   CREATE INDEX fki_name ON public.club USING btree (name);
    DROP INDEX public.fki_name;
       public         postgres    false    213            /           1259    16960    fki_name_club    INDEX     I   CREATE INDEX fki_name_club ON public.count_trof USING btree (name_club);
 !   DROP INDEX public.fki_name_club;
       public         postgres    false    215            ,           1259    17000    fki_stadium    INDEX     ?   CREATE INDEX fki_stadium ON public.club USING btree (stadium);
    DROP INDEX public.fki_stadium;
       public         postgres    false    213            0           1259    16954    fki_trof    INDEX     ?   CREATE INDEX fki_trof ON public.count_trof USING btree (trof);
    DROP INDEX public.fki_trof;
       public         postgres    false    215            J           2620    16740 #   pga_exception pga_exception_trigger    TRIGGER     �   CREATE TRIGGER pga_exception_trigger AFTER INSERT OR DELETE OR UPDATE ON pgagent.pga_exception FOR EACH ROW EXECUTE PROCEDURE pgagent.pga_exception_trigger();
 =   DROP TRIGGER pga_exception_trigger ON pgagent.pga_exception;
       pgagent       postgres    false    198    226                       0    0 .   TRIGGER pga_exception_trigger ON pga_exception    COMMENT     �   COMMENT ON TRIGGER pga_exception_trigger ON pgagent.pga_exception IS 'Update the job''s next run time whenever an exception changes';
            pgagent       postgres    false    2890            K           2620    16741    pga_job pga_job_trigger    TRIGGER     z   CREATE TRIGGER pga_job_trigger BEFORE UPDATE ON pgagent.pga_job FOR EACH ROW EXECUTE PROCEDURE pgagent.pga_job_trigger();
 1   DROP TRIGGER pga_job_trigger ON pgagent.pga_job;
       pgagent       postgres    false    240    200                       0    0 "   TRIGGER pga_job_trigger ON pga_job    COMMENT     ]   COMMENT ON TRIGGER pga_job_trigger ON pgagent.pga_job IS 'Update the job''s next run time.';
            pgagent       postgres    false    2891            L           2620    16742 !   pga_schedule pga_schedule_trigger    TRIGGER     �   CREATE TRIGGER pga_schedule_trigger AFTER INSERT OR DELETE OR UPDATE ON pgagent.pga_schedule FOR EACH ROW EXECUTE PROCEDURE pgagent.pga_schedule_trigger();
 ;   DROP TRIGGER pga_schedule_trigger ON pgagent.pga_schedule;
       pgagent       postgres    false    242    211                       0    0 ,   TRIGGER pga_schedule_trigger ON pga_schedule    COMMENT     �   COMMENT ON TRIGGER pga_schedule_trigger ON pgagent.pga_schedule IS 'Update the job''s next run time whenever a schedule changes';
            pgagent       postgres    false    2892            ;           2606    16743 (   pga_exception pga_exception_jexscid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_exception
    ADD CONSTRAINT pga_exception_jexscid_fkey FOREIGN KEY (jexscid) REFERENCES pgagent.pga_schedule(jscid) ON UPDATE RESTRICT ON DELETE CASCADE;
 S   ALTER TABLE ONLY pgagent.pga_exception DROP CONSTRAINT pga_exception_jexscid_fkey;
       pgagent       postgres    false    211    2854    198            <           2606    16748    pga_job pga_job_jobagentid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_job
    ADD CONSTRAINT pga_job_jobagentid_fkey FOREIGN KEY (jobagentid) REFERENCES pgagent.pga_jobagent(jagpid) ON UPDATE RESTRICT ON DELETE SET NULL;
 J   ALTER TABLE ONLY pgagent.pga_job DROP CONSTRAINT pga_job_jobagentid_fkey;
       pgagent       postgres    false    202    2839    200            =           2606    16753    pga_job pga_job_jobjclid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_job
    ADD CONSTRAINT pga_job_jobjclid_fkey FOREIGN KEY (jobjclid) REFERENCES pgagent.pga_jobclass(jclid) ON UPDATE RESTRICT ON DELETE RESTRICT;
 H   ALTER TABLE ONLY pgagent.pga_job DROP CONSTRAINT pga_job_jobjclid_fkey;
       pgagent       postgres    false    200    2842    203            >           2606    16758 #   pga_joblog pga_joblog_jlgjobid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_joblog
    ADD CONSTRAINT pga_joblog_jlgjobid_fkey FOREIGN KEY (jlgjobid) REFERENCES pgagent.pga_job(jobid) ON UPDATE RESTRICT ON DELETE CASCADE;
 N   ALTER TABLE ONLY pgagent.pga_joblog DROP CONSTRAINT pga_joblog_jlgjobid_fkey;
       pgagent       postgres    false    205    200    2837            ?           2606    16763 %   pga_jobstep pga_jobstep_jstjobid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_jobstep
    ADD CONSTRAINT pga_jobstep_jstjobid_fkey FOREIGN KEY (jstjobid) REFERENCES pgagent.pga_job(jobid) ON UPDATE RESTRICT ON DELETE CASCADE;
 P   ALTER TABLE ONLY pgagent.pga_jobstep DROP CONSTRAINT pga_jobstep_jstjobid_fkey;
       pgagent       postgres    false    207    2837    200            @           2606    16768 +   pga_jobsteplog pga_jobsteplog_jsljlgid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_jobsteplog
    ADD CONSTRAINT pga_jobsteplog_jsljlgid_fkey FOREIGN KEY (jsljlgid) REFERENCES pgagent.pga_joblog(jlgid) ON UPDATE RESTRICT ON DELETE CASCADE;
 V   ALTER TABLE ONLY pgagent.pga_jobsteplog DROP CONSTRAINT pga_jobsteplog_jsljlgid_fkey;
       pgagent       postgres    false    205    2845    209            A           2606    16773 +   pga_jobsteplog pga_jobsteplog_jsljstid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_jobsteplog
    ADD CONSTRAINT pga_jobsteplog_jsljstid_fkey FOREIGN KEY (jsljstid) REFERENCES pgagent.pga_jobstep(jstid) ON UPDATE RESTRICT ON DELETE CASCADE;
 V   ALTER TABLE ONLY pgagent.pga_jobsteplog DROP CONSTRAINT pga_jobsteplog_jsljstid_fkey;
       pgagent       postgres    false    2848    209    207            B           2606    16778 '   pga_schedule pga_schedule_jscjobid_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY pgagent.pga_schedule
    ADD CONSTRAINT pga_schedule_jscjobid_fkey FOREIGN KEY (jscjobid) REFERENCES pgagent.pga_job(jobid) ON UPDATE RESTRICT ON DELETE CASCADE;
 R   ALTER TABLE ONLY pgagent.pga_schedule DROP CONSTRAINT pga_schedule_jscjobid_fkey;
       pgagent       postgres    false    2837    211    200            G           2606    16928    liga country    FK CONSTRAINT     x   ALTER TABLE ONLY public.liga
    ADD CONSTRAINT country FOREIGN KEY (country_id) REFERENCES public.country(country_id);
 6   ALTER TABLE ONLY public.liga DROP CONSTRAINT country;
       public       postgres    false    220    2872    214            C           2606    16975    club country    FK CONSTRAINT     u   ALTER TABLE ONLY public.club
    ADD CONSTRAINT country FOREIGN KEY (country) REFERENCES public.country(country_id);
 6   ALTER TABLE ONLY public.club DROP CONSTRAINT country;
       public       postgres    false    213    220    2872            D           2606    16983 	   club liga    FK CONSTRAINT     i   ALTER TABLE ONLY public.club
    ADD CONSTRAINT liga FOREIGN KEY (liga) REFERENCES public.liga(liga_id);
 3   ALTER TABLE ONLY public.club DROP CONSTRAINT liga;
       public       postgres    false    2862    213    214            E           2606    16989 	   club name    FK CONSTRAINT     i   ALTER TABLE ONLY public.club
    ADD CONSTRAINT name FOREIGN KEY (name) REFERENCES public.name_club(id);
 3   ALTER TABLE ONLY public.club DROP CONSTRAINT name;
       public       postgres    false    223    213    2874            I           2606    16955    count_trof name_club    FK CONSTRAINT     y   ALTER TABLE ONLY public.count_trof
    ADD CONSTRAINT name_club FOREIGN KEY (name_club) REFERENCES public.name_club(id);
 >   ALTER TABLE ONLY public.count_trof DROP CONSTRAINT name_club;
       public       postgres    false    223    215    2874            F           2606    16995    club stadium    FK CONSTRAINT     m   ALTER TABLE ONLY public.club
    ADD CONSTRAINT stadium FOREIGN KEY (stadium) REFERENCES public.stadium(id);
 6   ALTER TABLE ONLY public.club DROP CONSTRAINT stadium;
       public       postgres    false    2868    213    216            H           2606    16949    count_trof trof    FK CONSTRAINT     j   ALTER TABLE ONLY public.count_trof
    ADD CONSTRAINT trof FOREIGN KEY (trof) REFERENCES public.trof(id);
 9   ALTER TABLE ONLY public.count_trof DROP CONSTRAINT trof;
       public       postgres    false    217    215    2870            �      x������ � �      �      x������ � �      �   <   x�34�04�420��50�5�T00�20�22�322556�60�*-�I����K����� �      �   X   x�3��/-��KU�M��+I�K�KN�2�tI,IT��-�/*�2��\+�</�477�(�8�$3?�˔�7�895''1/5���+F��� �B�      �      x������ � �      �      x������ � �      �      x������ � �      �      x������ � �      �   o   x��ML)�L�4�45�50"NC#N30��)M�H-�.�4�4CK.�Ģ�Ԝ��Dd-��:���û2����\��L�ИӀ����#��8;�,39�ӄ�����+F��� f{!�      �     x�=��q�0�O�d�/�&R���#�b��gW`eA ���<�z��.�������#Ф(tSz(-J�%aB�0��r�̯Ԃ��ƂR�`,(���΂J8j�YP΂�?�[�k-xP��o����E	Ģ$B(���0J!X �X �`�(�b�#X �d�$���,����=^��#�A^v9 �L?x��Fz�������76�����۴�HJ�lJ��/�����:�k��[/�{�g��~�,h<���y� 
�      �   r   x�.H���4�rO-�M̫�4�
�.
�rs���$�p�p�g&r�r����'�p�q��&�r�s��rZpy�$�TrZr�����5p'痀��N����\1z\\\ �, W      �   ~   x�uusTp�H�-���+V�IML/M�4估����.l���b�2�� ��b#P�W(H�kiQ~A"L�Z�`Z�KR��K8���f���v-H�	M`��sSA���kJ�!�@Cb���� r��0      �   �   x�%�;
A�~��b�7� ��bf�h�͎=23��w��Q��b:�i%�$��JYCt�����梩wu+�����zi3�t� ��ԟ��t���X��:M�6���w^̴1�Oii�d��.�5�1��j�Z�5dO�ȥX�	
��VM=�xN�X��K?�mL5�>�e?�      �   >  x�u��N1���S4�5�k;���,Ld�w	qA�$o	�0F@A�W8�y
j3���s��=ݭ7��gf�d��贡bkݖ�����R��3>��/��KS���cò��05��ҒK9���x��q`����`����%��TQQ�J%�W	����t�
o��`HÔï��4��b�M�T��I�bΛ=Y�ґJ�D�#=�f�? �R�i<�>b�^�%Y�R8��V���ؐF?̇.T�3�rJ"}�K]���,��7��d��4c�~cP�?��bWYR���x�z�Mm�Y�Bk����m��7/@�      �   c   x�s--�/HM�Sp�H�-��2rJ���K8-M�t��Ӑ+���Q!<?75"id �I�B$�RӁ�1dM ����EPc͍�rF94Qc�=...  �'     