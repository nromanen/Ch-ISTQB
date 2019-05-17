PGDMP         %                w        	   orders_db    10.7    11.2 0    d           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            e           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            f           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            g           1262    41504 	   orders_db    DATABASE     �   CREATE DATABASE orders_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE orders_db;
             postgres    false            �            1259    41520 	   customers    TABLE     Y   CREATE TABLE public.customers (
    user_id integer NOT NULL,
    location_id integer
);
    DROP TABLE public.customers;
       public         postgres    false            �            1259    41505 	   employees    TABLE     �   CREATE TABLE public.employees (
    user_id integer NOT NULL,
    chief_id integer,
    birth_date date,
    hire_date date,
    address character varying,
    location_id integer
);
    DROP TABLE public.employees;
       public         postgres    false            �            1259    41508 	   locations    TABLE     v   CREATE TABLE public.locations (
    id integer NOT NULL,
    city character varying,
    country character varying
);
    DROP TABLE public.locations;
       public         postgres    false            �            1259    41523    ordered_products    TABLE     �   CREATE TABLE public.ordered_products (
    orders_id integer,
    products_id integer,
    historical_price numeric,
    quantity integer
);
 $   DROP TABLE public.ordered_products;
       public         postgres    false            �            1259    41514    orders    TABLE     �   CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_id integer,
    product_name_id integer,
    order_date date,
    responsible_employee integer
);
    DROP TABLE public.orders;
       public         postgres    false            �            1259    41517    products    TABLE     �   CREATE TABLE public.products (
    id integer NOT NULL,
    product_name character varying,
    product_category_id integer,
    unit_price numeric,
    location_id integer
);
    DROP TABLE public.products;
       public         postgres    false            �            1259    41526    products_categories    TABLE     j   CREATE TABLE public.products_categories (
    id integer NOT NULL,
    category_name character varying
);
 '   DROP TABLE public.products_categories;
       public         postgres    false            �            1259    41511    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying,
    last_name character varying,
    location_id integer
);
    DROP TABLE public.users;
       public         postgres    false            _          0    41520 	   customers 
   TABLE DATA                     public       postgres    false    201   V2       Z          0    41505 	   employees 
   TABLE DATA                     public       postgres    false    196   �2       [          0    41508 	   locations 
   TABLE DATA                     public       postgres    false    197   P4       `          0    41523    ordered_products 
   TABLE DATA                     public       postgres    false    202   ?5       ]          0    41514    orders 
   TABLE DATA                     public       postgres    false    199   6       ^          0    41517    products 
   TABLE DATA                     public       postgres    false    200   /7       a          0    41526    products_categories 
   TABLE DATA                     public       postgres    false    203   ^8       \          0    41511    users 
   TABLE DATA                     public       postgres    false    198   �8       �
           2606    41573    customers customers_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (user_id);
 B   ALTER TABLE ONLY public.customers DROP CONSTRAINT customers_pkey;
       public         postgres    false    201            �
           2606    41594    employees employees_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (user_id);
 B   ALTER TABLE ONLY public.employees DROP CONSTRAINT employees_pkey;
       public         postgres    false    196            �
           2606    41563    locations locations_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.locations DROP CONSTRAINT locations_pkey;
       public         postgres    false    197            �
           2606    41551    orders orders_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.orders DROP CONSTRAINT orders_pkey;
       public         postgres    false    199            �
           2606    41571 ,   products_categories products_categories_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.products_categories
    ADD CONSTRAINT products_categories_pkey PRIMARY KEY (id);
 V   ALTER TABLE ONLY public.products_categories DROP CONSTRAINT products_categories_pkey;
       public         postgres    false    203            �
           2606    41569    products products_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.products DROP CONSTRAINT products_pkey;
       public         postgres    false    200            �
           2606    41553    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public         postgres    false    198            �
           1259    41645    fki_category    INDEX     P   CREATE INDEX fki_category ON public.products USING btree (product_category_id);
     DROP INDEX public.fki_category;
       public         postgres    false    200            �
           1259    41605 	   fki_chief    INDEX     C   CREATE INDEX fki_chief ON public.employees USING btree (chief_id);
    DROP INDEX public.fki_chief;
       public         postgres    false    196            �
           1259    41633    fki_customer    INDEX     F   CREATE INDEX fki_customer ON public.orders USING btree (customer_id);
     DROP INDEX public.fki_customer;
       public         postgres    false    199            �
           1259    41561    fki_customers    INDEX     F   CREATE INDEX fki_customers ON public.customers USING btree (user_id);
 !   DROP INDEX public.fki_customers;
       public         postgres    false    201            �
           1259    41611    fki_location    INDEX     I   CREATE INDEX fki_location ON public.employees USING btree (location_id);
     DROP INDEX public.fki_location;
       public         postgres    false    196            �
           1259    41656    fki_location_id    INDEX     K   CREATE INDEX fki_location_id ON public.products USING btree (location_id);
 #   DROP INDEX public.fki_location_id;
       public         postgres    false    200            �
           1259    41639    fki_product_name    INDEX     N   CREATE INDEX fki_product_name ON public.orders USING btree (product_name_id);
 $   DROP INDEX public.fki_product_name;
       public         postgres    false    199            �
           1259    41617    fki_products    INDEX     N   CREATE INDEX fki_products ON public.ordered_products USING btree (orders_id);
     DROP INDEX public.fki_products;
       public         postgres    false    202            �
           1259    41670    fki_users_location    INDEX     K   CREATE INDEX fki_users_location ON public.users USING btree (location_id);
 &   DROP INDEX public.fki_users_location;
       public         postgres    false    198            �
           2606    41640    products category    FK CONSTRAINT     �   ALTER TABLE ONLY public.products
    ADD CONSTRAINT category FOREIGN KEY (product_category_id) REFERENCES public.products_categories(id);
 ;   ALTER TABLE ONLY public.products DROP CONSTRAINT category;
       public       postgres    false    200    203    2772            �
           2606    41600    employees chief    FK CONSTRAINT     o   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT chief FOREIGN KEY (chief_id) REFERENCES public.users(id);
 9   ALTER TABLE ONLY public.employees DROP CONSTRAINT chief;
       public       postgres    false    196    198    2758            �
           2606    41574    customers customer    FK CONSTRAINT     q   ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customer FOREIGN KEY (user_id) REFERENCES public.users(id);
 <   ALTER TABLE ONLY public.customers DROP CONSTRAINT customer;
       public       postgres    false    198    2758    201            �
           2606    41628    orders customer    FK CONSTRAINT     {   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT customer FOREIGN KEY (customer_id) REFERENCES public.customers(user_id);
 9   ALTER TABLE ONLY public.orders DROP CONSTRAINT customer;
       public       postgres    false    201    199    2768            �
           2606    41606    employees location    FK CONSTRAINT     y   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT location FOREIGN KEY (location_id) REFERENCES public.locations(id);
 <   ALTER TABLE ONLY public.employees DROP CONSTRAINT location;
       public       postgres    false    2755    197    196            �
           2606    41646    products location    FK CONSTRAINT     x   ALTER TABLE ONLY public.products
    ADD CONSTRAINT location FOREIGN KEY (location_id) REFERENCES public.locations(id);
 ;   ALTER TABLE ONLY public.products DROP CONSTRAINT location;
       public       postgres    false    2755    200    197            �
           2606    41651    products location_id    FK CONSTRAINT     {   ALTER TABLE ONLY public.products
    ADD CONSTRAINT location_id FOREIGN KEY (location_id) REFERENCES public.locations(id);
 >   ALTER TABLE ONLY public.products DROP CONSTRAINT location_id;
       public       postgres    false    200    2755    197            �
           2606    41618    ordered_products orders    FK CONSTRAINT     y   ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT orders FOREIGN KEY (orders_id) REFERENCES public.orders(id);
 A   ALTER TABLE ONLY public.ordered_products DROP CONSTRAINT orders;
       public       postgres    false    199    2762    202            �
           2606    41634    orders product_name    FK CONSTRAINT     }   ALTER TABLE ONLY public.orders
    ADD CONSTRAINT product_name FOREIGN KEY (product_name_id) REFERENCES public.products(id);
 =   ALTER TABLE ONLY public.orders DROP CONSTRAINT product_name;
       public       postgres    false    199    200    2766            �
           2606    41623    ordered_products products    FK CONSTRAINT        ALTER TABLE ONLY public.ordered_products
    ADD CONSTRAINT products FOREIGN KEY (products_id) REFERENCES public.products(id);
 C   ALTER TABLE ONLY public.ordered_products DROP CONSTRAINT products;
       public       postgres    false    2766    202    200            �
           2606    41595    employees users    FK CONSTRAINT     n   ALTER TABLE ONLY public.employees
    ADD CONSTRAINT users FOREIGN KEY (user_id) REFERENCES public.users(id);
 9   ALTER TABLE ONLY public.employees DROP CONSTRAINT users;
       public       postgres    false    2758    198    196            �
           2606    41665    users users_location    FK CONSTRAINT     {   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_location FOREIGN KEY (location_id) REFERENCES public.locations(id);
 >   ALTER TABLE ONLY public.users DROP CONSTRAINT users_location;
       public       postgres    false    197    198    2755            _   m   x���v
Q���W((M��L�K.-.��M-*V�(-N-��L�Q��ON,���r4�}B]�4��u��5��<)2�d�����1���1&c
2�h @To
      Z   m  x����J�0��]�w������8�S���#k���h;E��$���@��<�y��v��`�=<��r�Mz��sn���av�uu4*�43�=�N�j����� 3��R�J�u�Mecl����f��Ìa�$�)	A�"��a��,L\� �������n�&�t~=Y��d����L���%��Y�rY*��̧R6���1¤�)!�w�1��)
Y�vV���#:�s%$d�q�0C$Ԁ��u3s1"2�ȸEr�j�鐼GRA���k����]��u�O�]<k���|�Rٯ��ndن��*V�V���V&�����:po�Y	x���v� ���T��p��ʰ�N&����      [   �   x����j�0�{�·�PF��/=��-��K��j�"p�جy���,��~||R}h6_GU��'K��:��jBf�4�!N��0U?����Q�jq?S�ޱq\�m'^��<��eQ�_^D���oX�H�����_V�xi>D��G��%}�P���r��>���pɆ>'D�uIm�����j�L.�5:oN|�d;5�Ҋ�/JW޾˞)�	-�+b	      `   �   x��ҽ
�0�ݧ����&�ҩ��P,T�Ul"4 ��8��{����,���8I��)/-Tu{�y��J���d7�I��,�n��S҇�p�<�b&�D?�a%^k�4ʼ=�Oײ��<�Zy�����d��19�|7;fL&Fd�n2)��LI�Ȱ�1#��0�f�db0�fA&F��ɬ���5�?�q>�{{�      ]     x��Իj�0��O��	XE��2d0����Il;6�y��HD� ?Hh���Q}��n��ܾѼ?������-+:�]��}ݦ�-l�e��vk��х�p�����yz��cp��az9wD�������B�(���))�a�Ϣ�%a �P>JF���$<���B�$�� 9%$JD	���L��)� �P2J�h(f:HtN�J�UQ"�tD������Da�ߍ�9%&5�D���OG�����k����P��?���XM��� ��?)�I��      ^     x����j�0�{���ق����j�^�+��V�j�&#�o��+{�\I>L~�{bYՇSe�|�8�����n�v���"��ZŮ���̊�6��M����h$�	��!�l�����PÆ�y��<Yf:�!�F@3��$߾���I�Y��Vbq�H�8I�OR��W0l5��3�ğ������.���r�{3���a�#�-3���?#�T�k{��Q�����n�a��@����A\����(�#��Ȗ�a��?��sd��_xb�众zE���I�/I��      a   �   x���v
Q���W((M��L�+(�O)M.)�ON,IM�/�L-V��L�Q��+��sS5�}B]�4�Mu�݊J3K��5��<�a��Ȱ��ԒĤ�T�k4�5'5��(?/3�z� �u��/���K�� �vq%      \   \  x���KO1�;��7 !�<�i��(>¢WR�(��t�����F�@9�����N���b�ް�������U����DW��zL����£5[�u�{�z�����k��@;�+��A)g��uk��P����vqh��vde�-�G�=���*�Ud���0Z�	���@�;�p�\�/h�jaO�3A���8NXM�+�(��ʄ�����I� Gh�a���V��ڙ�{ h���a �Ի5�j�7K���a���������i��.���JZj���K�Ϩu�TS^��D:p��X ���T[�d�C�?����[Yja�%�p��������eC������     