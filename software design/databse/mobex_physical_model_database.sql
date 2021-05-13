CREATE TABLE emp (
  user_name             varchar(255) NOT NULL, 
  token                 varchar(255) NOT NULL UNIQUE, 
  card_id               varchar(11) NOT NULL UNIQUE, 
  phone                 varchar(10) NOT NULL, 
  city                  varchar(255) NOT NULL, 
  address               varchar(255) NOT NULL, 
  sex                   char(1) NOT NULL, 
  first_name            varchar(255) NOT NULL, 
  father_name           varchar(255) NOT NULL, 
  last_name             varchar(255) NOT NULL, 
  mother_name           varchar(255) NOT NULL, 
  id_image              varchar(1000) NOT NULL, 
  data_of_birth         date NOT NULL, 
  account_creation_date date NOT NULL, 
  account_status        varchar(50) NOT NULL, 
  profile_image         varchar(1000) NOT NULL, 
  balance               float NOT NULL, 
  PRIMARY KEY (user_name));
  
  
CREATE TABLE customer (
  user_name             varchar(255) NOT NULL, 
  token                 varchar(255) NOT NULL UNIQUE, 
  card_id               varchar(11) NOT NULL UNIQUE, 
  phone                 varchar(10) NOT NULL, 
  city                  varchar(255) NOT NULL, 
  address               varchar(255) NOT NULL, 
  sex                   char(1) NOT NULL, 
  first_name            varchar(255) NOT NULL, 
  father_name           varchar(255) NOT NULL, 
  last_name             varchar(255) NOT NULL, 
  mother_name           varchar(255) NOT NULL, 
  id_image              varchar(1000) NOT NULL, 
  data_of_birth         date NOT NULL, 
  account_creation_date date NOT NULL, 
  account_status        varchar(50) NOT NULL, 
  profile_image         varchar(1000) NOT NULL, 
  balance               float NOT NULL, 
  PRIMARY KEY (user_name));
  
  
CREATE TABLE store (
  store_no         int(11) NOT NULL AUTO_INCREMENT, 
  store_name       varchar(30) NOT NULL, 
  user_name        varchar(255) NOT NULL, 
  store_bio        varchar(100) NOT NULL, 
  frozen_assets    float NOT NULL, 
  available_assets float NOT NULL, 
  over_all_profit  float NOT NULL, 
  PRIMARY KEY (store_no), 
  INDEX (store_name));
  
  
CREATE TABLE `order` (
  order_no   int(11) NOT NULL AUTO_INCREMENT, 
  user_name  varchar(255) NOT NULL, 
  order_date date NOT NULL, 
  PRIMARY KEY (order_no));
  
CREATE TABLE product (
  product_no          int(11) NOT NULL AUTO_INCREMENT, 
  product_name        varchar(50) NOT NULL, 
  product_price       float NOT NULL, 
  product_category    varchar(30) NOT NULL, 
  store_no            int(11) NOT NULL, 
  product_description varchar(200) NOT NULL, 
  offer               float NOT NULL, 
  product_image       varchar(1000) NOT NULL, 
  PRIMARY KEY (product_no), 
  INDEX (product_name), 
  INDEX (product_price), 
  INDEX (product_category));
  
  
CREATE TABLE order_items (
  order_no   int(11) NOT NULL, 
  product_no int(11) NOT NULL, 
  price      float NOT NULL, 
  quantity   int(2) NOT NULL, 
  PRIMARY KEY (order_no, 
  product_no));
  
  
CREATE TABLE `transaction` (
  order_no         int(11) NOT NULL, 
  product_no       int(11) NOT NULL, 
  transaction_type int(11) NOT NULL, 
  transaction_date date NOT NULL, 
  PRIMARY KEY (order_no, 
  product_no, 
  transaction_type));
  
  
CREATE TABLE follow (
  user_name varchar(255) NOT NULL, 
  store_no  int(11) NOT NULL, 
  PRIMARY KEY (user_name, 
  store_no));
  
  
CREATE TABLE rate (
  user_name  varchar(255) NOT NULL, 
  product_no int(11) NOT NULL, 
  rate       float NOT NULL, 
  PRIMARY KEY (user_name, 
  product_no));
  
  
ALTER TABLE store ADD CONSTRAINT FKstore629423 FOREIGN KEY (user_name) REFERENCES customer (user_name);

ALTER TABLE `order` ADD CONSTRAINT FKorder864792 FOREIGN KEY (user_name) REFERENCES customer (user_name);

ALTER TABLE order_items ADD CONSTRAINT FKorder_item673204 FOREIGN KEY (order_no) REFERENCES `order` (order_no);

ALTER TABLE order_items ADD CONSTRAINT FKorder_item601025 FOREIGN KEY (product_no) REFERENCES product (product_no);

ALTER TABLE `transaction` ADD CONSTRAINT FKtransactio964804 FOREIGN KEY (order_no, product_no) REFERENCES order_items (order_no, product_no);

ALTER TABLE rate ADD CONSTRAINT FKrate351428 FOREIGN KEY (user_name) REFERENCES customer (user_name);

ALTER TABLE rate ADD CONSTRAINT FKrate931541 FOREIGN KEY (product_no) REFERENCES product (product_no);

ALTER TABLE follow ADD CONSTRAINT FKfollow898780 FOREIGN KEY (user_name) REFERENCES customer (user_name);

ALTER TABLE follow ADD CONSTRAINT FKfollow839891 FOREIGN KEY (store_no) REFERENCES store (store_no);

ALTER TABLE product ADD CONSTRAINT FKproduct354710 FOREIGN KEY (store_no) REFERENCES store (store_no);




