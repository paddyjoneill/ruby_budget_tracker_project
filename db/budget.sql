DROP TABLE transactions;
DROP TABLE merchants;
DROP TABLE categories;
DROP TABLE budgets;

CREATE TABLE budgets
(
  id SERIAL primary key,
  monthly_budget INT,
  target INT,
  income INT
);

CREATE TABLE categories
(
  id SERIAL primary key,
  name VARCHAR(255) not null,
  active BOOLEAN
);

CREATE TABLE merchants
(
  id SERIAL primary key,
  name VARCHAR(255) not null,
  default_cat_id INT references categories(id),
  active BOOLEAN
);

CREATE TABLE transactions
(
  id SERIAL primary key,
  merchant_id INT references merchants(id),
  category_id INT references categories(id),
  amount INT,
  time VARCHAR(255),
  date VARCHAR(255)
);
