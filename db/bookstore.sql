DROP TABLE books;
DROP TABLE authors;

CREATE TABLE authors (
  id serial4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE books (
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  genre VARCHAR(255),
  author_id INT4 REFERENCES authors(id) ON DELETE CASCADE,
  stock INT4,
  price INT4
);
