DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE categories;

CREATE TABLE categories
(
  id SERIAL primary key,
  name VARCHAR(255) not null
);

CREATE TABLE merchants
(
  id SERIAL primary key,
  name VARCHAR(255) not null,
  default_cat_id INT references categories(id)
);

CREATE TABLE transactions
(
  id SERIAL primary key,
  merchant_id INT references merchants(id),
  category_id INT references categories(id)
);
