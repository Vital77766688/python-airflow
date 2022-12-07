-- Active: 1669972608469@@127.0.0.1@5432@dwh
CREATE SCHEMA stage;

CREATE TABLE stage.b2b_companies (
  id int,
  CUIT varchar(256),
  company_name varchar(150),
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);

CREATE TABLE stage.b2b_suppliers (
  id int,
  CUIT varchar(256),
  supplier_name varchar(150),
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);

CREATE TABLE stage.b2b_customers (
  id int,
  document_number varchar(256),
  full_name varchar(150),
  username varchar(50),
  date_of_birth date,
  country varchar(2),
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);

CREATE TABLE stage.b2b_products (
  id int,
  supplier_id int,
  product_name varchar(150),
  default_price numeric,
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);

CREATE TABLE stage.b2b_company_products (
  id int,
  company_id int,
  product_id int,
  price numeric,
  is_active boolean,
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);


CREATE TABLE stage.b2b_orders (
  id int,
  company_id int,
  customer_id int,
  order_dt timestamp,
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);

CREATE TABLE stage.b2b_order_items (
  id int,
  order_id int,
  company_product_id int,
  price numeric,
  qty int,
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
);

CREATE TABLE stage.weblogs_weblog (
  remote_host varchar(256),
  username varchar(256),
  TIMESTAMP timestamp,
  user_agent varchar(256),
  record_hash varchar(256),
  load_date timestamp,
  record_dt timestamp
)
