DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS merchants;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  username VARCHAR(255),
  balance NUMERIC
);

CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE merchants (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(id),
  category_id INT REFERENCES categories(id),
  merchant_id INT REFERENCES merchants(id),
  value NUMERIC
);
