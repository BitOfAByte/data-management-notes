[[Data management lecture 1]]


## Deleting a  database

```sql
DROP database dbName
```


<strong> <span style="color:red">Active connections to a database will block a deletion attempt!</span> </strong>

## Creating Tables with Relationships

```sql
CREATE TABLE account (id serial PRIMARY KEY,
					 username varchar(50) UNIQUE NOT NULL,
					 password varchar(50) NOT NULL,
					 email varchar(255) NOT NULL,
					 created_on timestamp default NOW()
);


CREATE TABLE blog_entries (id serial PRIMARY KEY, 
						  header varchar(255) not null,
						  body TEXT not null,
						  created_by integer NOT NULL REFERENCES account(id)
);
```



## Constraint Enforcement

```sql
INSERT INTO accounts (username, password, email) VALUES ('Tobias', 'Tobias123', 'tobias@email.com'); -- becomes user 1
```

```sql
INSERT INTO blog_entries (header, body, created_by) VALUES ('My article', 'Hello world', 1); -- Works
```


```sql
INSERT INTO blog_entries (header, body, created_by) VALUES ('My article', 'Hello world', 6); --Error!
```


<span style="color:red">Error: insert or update on table "blog_entires" violates foreign key constraint "blog_entires_created_by_fkey" <br/>
Detail: Key (created_by = 6) is not present in the table "account"

</span>


## Querying Your Result Set - Nested Queries


```sql
SELECT * FROM account, blog_entries WHERE blog_entires.created_by = account.id;
```

can be written as:

```sql
select username, email, created_by from (
	select * from account, blog_entries where blog_entires.created_by = accounts.id
) as result_set where created_by = 2
```


## Join types

- INNER JOIN→ For each row R1 of T1, the joined table has a row for each row in T2 that satisfies the join condition with R1.
- LEFT OUTER JOIN → First, an inner join is performed. Then, for each row in T1 that does not satisfy the join condition with any row in T2, a joined row is added with null values in columns of T2. Thus, the joined table always has at least one row for each row in T1.
- RIGHT OUTER JOIN → First, an inner join is performed. Then, for each row in T2 that does not satisfy the join condition with any row in T1, a joined row is added with null values in columns of T1. This is the converse of a left join: the result table will always have a row for each row in T2.
- FULL OUTER JOIN → First, an inner join is performed. Then, for each row in T1 that does not satisfy the join condition with any row in T2, a joined row is added with null values in columns of T2. Also, for each row of T2 that does not satisfy the join condition with any row in T1, a joined row with null values in the columns of T1 is added.


[Source](https://www.postgresql.org/docs/9.2/queries-table-expressions.html)

### Inner Join


#### T1 table:

| num | name |
| --- | ---- |
| 1   | a    |
| 2   | b    |
| 3   | c    |


#### T2 table:

| num | value |
| --- | ----- |
| 1   | xxx   |
| 3   | yyy   |
| 5   | zzz   |

```sql
SELECT * FROM t1 INNER JOIN t2 ON t1.num = t2.num;

SELECT * FROM t1, t2 WHERE t1.num = t2.num;
```

#### output:


| num | name | num | value |
| :-- | :--: | --: | ----- |
| 1   |  a   |   1 | xxx   |
| 3   |  c   |   3 | yyy   |

### Left Outer Join

#### T1 table

| num | name |
| --- | ---- |
| 1   | a    |
| 2   | b    |
| 3   | c    |


#### T2  table

| num | value |
| --- | ----- |
| 1   | xxx   |
| 3   | yyy   |
| 5   | zzz   |


```sql
	SELECT * FROM t1 LEFT JOIN t2 on t1.num = t2.num;
```


#### output

| num | name |  num | value |
| :-- | :--: | ---: | ----- |
| 1   |  a   |    1 | xxx   |
| 2   |  b   | null | null  |
| 3   |  c   |    3 | yyy   |

### Right Outer Join


#### T1 table

| num | name |
| --- | ---- |
| 1   | a    |
| 2   | b    |
| 3   | c    |


#### T2  table

| num | value |
| --- | ----- |
| 1   | xxx   |
| 3   | yyy   |
| 5   | zzz   |

```sql
SELECT * FROM t1 RIGHT JOIN t2 ON t1.num = t2.num;
```


#### output


| num  | name | num | value |
| :--- | :--: | --: | ----- |
| 1    |  a   |   1 | xxx   |
| 3    |  c   |   3 | yyy   |
| null | null |   5 | zzz   |

### Full Outer Join


| num | name |
| --- | ---- |
| 1   | a    |
| 2   | b    |
| 3   | c    |


#### T2  table

| num | value |
| --- | ----- |
| 1   | xxx   |
| 3   | yyy   |
| 5   | zzz   |


```sql
SELECT * FROM t1 FULL JOIN t2 on t1.num = t2.num;
```


#### output


| num  | name |  num | value |
| :--- | :--: | ---: | ----- |
| 1    |  a   |    1 | xxx   |
| 2    |  b   | null | null  |
| 3    |  c   |    3 | yyy   |
| null | null |    5 | zzz   |

## Views – Creating Virtual Tables


```sql
CREATE VIEW someView AS 
	SELECT email, username FROM accounts, blog_entires
	WHERE blog_entires.created_by = accounts.id


select * from someView
```




# Exercises

```sql
CREATE TABLE customers (

    id SERIAL PRIMARY KEY,

    username VARCHAR(50) NOT NULL,

    password VARCHAR(50) NOT NULL,

    email VARCHAR(50) UNIQUE NOT NULL,

    created_on TIMESTAMP DEFAULT NOW(),

    last_login TIMESTAMP

);

  

INSERT INTO customers(username, password, email) VALUES

    ('John', 'myPassW0rd', 'john@acme.com'),

    ('Anne', 'myPassW0rd', 'anne@acme.com');

  

CREATE TABLE IF NOT EXISTS products (

    id SERIAL PRIMARY KEY,

    name VARCHAR(150) NOT NULL,

    price FLOAT(2) NOT NULL

);

  

ALTER TABLE products ADD COLUMN manufacturer VARCHAR(250);

  

INSERT INTO products(name, price, manufacturer) VALUES

    ('Samsung galaxy s20', 7799.95, 'Samsung'),

    ('Samsung galaxy s20 - leather cover', 799.95, 'Samsung'),

    ('Iphone 11 pro', 8899, 'Apple'),

    ('Iphone 11 pro - leather cover', 399.5, 'Apple'),

    ('Huawai P30 lite', 1664.5, 'Google'),

    ('Huawai P30 - leather cover', 1664.5, 'Google');

  

CREATE TABLE IF NOT EXISTS orders (

    id SERIAL PRIMARY KEY,

    order_number VARCHAR(10) NOT NULL,

    customer_id INTEGER REFERENCES customers(id)

);

  

INSERT INTO orders (order_number, customer_id) VALUES

    ('DA-0001234', 1),

    ('DA-0001235', 1),

    ('DE-0001236', 2),

    ('DE-0001237', 2);

  

CREATE TABLE IF NOT EXISTS order_lines (

    id SERIAL PRIMARY KEY,

    order_id INTEGER REFERENCES orders(id),

    product_id INTEGER REFERENCES products(id),

    amount INTEGER NOT NULL

);

  

INSERT INTO order_lines (order_id, product_id, amount) VALUES

    (1,1,2),

    (1,2,2),

    (1,5,1),

    (3,3,2),

    (3,4,1),

    (4,1,1);

  

SELECT

    o.order_number,

    c.email AS customer_email,

    p.name AS product_name,

    ol.amount AS amount_bought

FROM

    orders o

JOIN

    customers c ON o.customer_id = c.id

JOIN

    order_lines ol ON o.id = ol.order_id

JOIN

    products p ON ol.product_id = p.id;

CREATE VIEW order_details_view AS

SELECT

    o.order_number,

    c.email AS customer_email,

    p.name AS product_name,

    ol.amount AS amount_bought

FROM

    orders o

JOIN

    customers c ON o.customer_id = c.id

JOIN

    order_lines ol ON o.id = ol.order_id

JOIN

    products p ON ol.product_id = p.id;

select * from order_details_view;

  
  

CREATE VIEW order_details_bro AS

SELECT

    o.order_number,

    c.email AS customer_email,

    p.name AS product_name,

    ol.amount AS amount_bought

FROM

    orders o

JOIN

    customers c ON o.customer_id = c.id

JOIN

    order_lines ol ON o.id = ol.order_id

JOIN

    products p ON ol.product_id = p.id

WHERE

    ol.order_id = 1;

select * from order_details_bro;
```

