use shop;
CREATE TABLE IF NOT EXISTS categories (id INT AUTO_INCREMENT not null, name varchar(255) not null, PRIMARY KEY (id));

CREATE TABLE IF NOT EXISTS items (id INT AUTO_INCREMENT not null, name varchar(255) not null, category_id INT not null, price INT(255) not null, PRIMARY KEY (id));


INSERT INTO categories (name) VALUES ('toys');
INSERT INTO categories (name) VALUES ('tools');
INSERT INTO categories (name) VALUES ('cars');

INSERT INTO items (name, category_id, price) VALUES ('toy_1', 1, 100);
INSERT INTO items (name, category_id, price) VALUES ('toy_2', 1, 200);
INSERT INTO items (name, category_id, price) VALUES ('tool_1', 2, 500);
INSERT INTO items (name, category_id, price)  VALUES ('car_1', 2, 200000);
INSERT INTO items (name, category_id, price) VALUES ('car_2', 3, 125000);


