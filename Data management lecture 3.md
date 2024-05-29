[[Data management lecture 1]]
[[Data management lecture 2]]


# Cardinalities 
- `1 -*` , one to many
- `*-1`, many to one
- `*-*`, many to many
- `1-1`, one to one
- `0..1-1`, zero/one to one


# Unnormalized form (UNF)

example of unnormalized table:

| Customer Name    |        Item        |            Shipping Address | Newsletter                  | Supplier  | Supplier Phone | Price |
| :--------------- | :----------------: | --------------------------: | --------------------------- | --------- | -------------- | ----- |
| Jens Bergholm    |      XBOX One      |  Mølletoften 20, 7100 Vejle | Xbox News                   | Microsft  | 12341234       | 1800  |
| Dennis Jørgensen |   Playstation 4    |   Vinkelvej 167, 7100 Vejle | Playstation news            | Sony      | 23452345       | 1900  |
| Hans Jensen      | XBOX One,  PS Vita | Kongensgade 45, 5000 Odense | Xbox news, playstation news | Wholesale | 00000000       | 3300  |
| Anne Johansen    |   Playstation 4    |   Vinkevej 167, 7100  Vejle | Playstation news            | Sony      | 23452345       | 1900  |

The table above is valuable for:
- insertion  anomalies
- update anomalies
- deletion  anomalies


# 1st Normal Form (NF1)

## rules of NF1:
- Each column  must contain atomic values
	- Only allowed to describe one thing at the time
	- values like `x,y` violates NF1
- A column should contain values of the same type
- Each  column name must  be unique
- Each row  must be unique


## table of first normal form

The table below has been normalized to NF1:

| ID  | Name             |     Item      |         Address | Zip  | City   | Newsletter       | Supplier | Phone    | Price |
| --- | :--------------- | :-----------: | --------------: | ---- | ------ | ---------------- | -------- | -------- | ----- |
| 1   | Jens Bergholm    |   XBOX One    |  Mølletoften 20 | 7100 | Vejle  | Xbox News        | Microsft | 12341234 | 1800  |
| 2   | Dennis Jørgensen | Playstation 4 |   Vinkelvej 167 | 7100 | Vejle  | Playstation News | Sony     | 23452345 | 1900  |
| 3   | Hans Jensen      |   XBOX One    | Kongensgrade 45 | 5000 | Odense | Xbox News        | Microsft | 12341234 | 1800  |
| 3   | Hans Jensen      |    PS Vita    | Kongensgrade 45 | 5000 | Odense | Playstation News | Sony     | 23452345 | 1900  |
| 4   | Anne Johansen    | Playstation 4 |   Vinkelvej 167 | 7100 | Vejle  | Playstation News | Sony     | 23452345 | 1900  |


## Functional Dependencies
- Strong Connection between two attributes in a table
	- denoted as `A -> B`
- A functionally  determines B or B is functionally dependent on A
	- Name and Item is the Determinant
- `Name: -> {Address, City, Newsletter}`
- `Zip -> City`
- `Item -> {Supplier, Phone, Price}`


## Partial Dependency
- An xbox one purchase  does not require you to be Jens Bergholm
- But there is  an decency as "Jens Bergholm" purchased this item


# 2nd Normal Form (NF2)

- Since a customer can buy multiple items, and multiple items can also be purchased by multiple users we have a many to many relationship between `Name` and `Item`
	- Which will result in a new table being created named `Order table`



The tables below have been  normalized to NF2


Customer Table:

| ID  | Name             |         Address | Zip  | City   | Newsletter       |
| --- | :--------------- | --------------: | ---- | ------ | ---------------- |
| 1   | Jens Bergholm    |  Mølletoften 20 | 7100 | Vejle  | Xbox News        |
| 2   | Dennis Jørgensen |   Vinkelvej 167 | 7100 | Vejle  | Playstation News |
| 3   | Hans Jensen      | Kongensgrade 45 | 5000 | Odense | Xbox News        |
| 3   | Hans Jensen      | Kongensgrade 45 | 5000 | Odense | Playstation News |
| 4   | Anne Johansen    |   Vinkelvej 167 | 7100 | Vejle  | Playstation News |

Products table:

| ID  | Name          | Supplier | Phone    | Price |
| --- | :------------ | -------- | -------- | ----- |
| 1   | XBOX Oone     | Microsft | 12341234 | 1800  |
| 2   | Playstation 4 | Sony     | 23452345 | 1900  |
| 3   | PS Vita       | Sony     | 23452345 | 1500  |

Orders table:

| Customer ID | Product ID |
| ----------- | ---------- |
| 1           | 1          |
| 2           | 2          |
| 3           | 1          |
| 3           | 3          |
| 4           | 2          |


# Third Normal Form (NF3)

- A table is said to be in NF if and only if:
	- The table is in NF2
	- Every attribute in the table that do not  belong to a candidate key should depend on every candidate key of that table


Tables below have been normalized to  NF3


| ID  | Name             |         Address | Zip  | City   | Newsletter       |
| --- | :--------------- | --------------: | ---- | ------ | ---------------- |
| 1   | Jens Bergholm    |  Mølletoften 20 | 7100 | Vejle  | Xbox News        |
| 2   | Dennis Jørgensen |   Vinkelvej 167 | 7100 | Vejle  | Playstation News |
| 3   | Hans Jensen      | Kongensgrade 45 | 5000 | Odense | Xbox News        |
| 3   | Hans Jensen      | Kongensgrade 45 | 5000 | Odense | Playstation News |
| 4   | Anne Johansen    |   Vinkelvej 167 | 7100 | Vejle  | Playstation News |

Products table:

| ID  | Name          | Phone    | Price | Supplier  ID |
| --- | :------------ | -------- | ----- | ------------ |
| 1   | XBOX Oone     | 12341234 | 1800  | 1            |
| 2   | Playstation 4 | 23452345 | 1900  | 2            |
| 3   | PS Vita       | 23452345 | 1500  | 2            |

Suppliers  table:


| ID  | Name      | Phone    |
| --- | :-------- | -------- |
| 1   | Microsoft | 12341234 |
| 2   | Sony      | 23452345 |


Orders table:

| Customer ID | Product ID |
| ----------- | ---------- |
| 1           | 1          |
| 2           | 2          |
| 3           | 1          |
| 3           | 3          |
| 4           | 2          |

#  Boyce-Codd Normal Form (BCNF)

- a table supports BCNF if:
	- the  table is in NF3
	- If a relational schema is in BCNF then all   it's redundancy based on functional dependencies has been removed, although other types of redundancy may still exist



Tables below supports bcnf



| ID  | Name             |         Address | Newsletter       | Zip ID |
| --- | :--------------- | --------------: | ---------------- | ------ |
| 1   | Jens Bergholm    |  Mølletoften 20 | Xbox News        | 7100   |
| 2   | Dennis Jørgensen |   Vinkelvej 167 | Playstation News | 7100   |
| 3   | Hans Jensen      | Kongensgrade 45 | Xbox News        | 5000   |
| 3   | Hans Jensen      | Kongensgrade 45 | Playstation News | 5000   |
| 4   | Anne Johansen    |   Vinkelvej 167 | Playstation News | 7100   |

zip table:

| zip  | name   |
| ---- | ------ |
| 7100 | Vejle  |
| 5000 | Odense |



Products table:

| ID  | Name          | Phone    | Price | Supplier  ID |
| --- | :------------ | -------- | ----- | ------------ |
| 1   | XBOX Oone     | 12341234 | 1800  | 1            |
| 2   | Playstation 4 | 23452345 | 1900  | 2            |
| 3   | PS Vita       | 23452345 | 1500  | 2            |

Suppliers  table:


| ID  | Name      | Phone    |
| --- | :-------- | -------- |
| 1   | Microsoft | 12341234 |
| 2   | Sony      | 23452345 |


Orders table:

| Customer ID | Product ID |
| ----------- | ---------- |
| 1           | 1          |
| 2           | 2          |
| 3           | 1          |
| 3           | 3          |
| 4           | 2          |


# 4th Normal Form (NF4)

- All columns can be determined only by the key in the table and no other column 
- Table must support  BCNF
- No  Multi-valued Dependencies


Tables below supports NF4



Newsletters table:

| ID  | Newsletter       |
| --- | ---------------- |
| 1   | Xbox News        |
| 2   | PlayStation News |


Subscription table:


| Newsletter ID | Customer ID |
| ------------- | ----------- |
| 1             | 1           |
| 2             | 2           |
| 1             | 3           |
| 2             | 3           |
| 2             | 4           |



Customer Table:

| ID  | Name             |         Address | Zip ID |
| --- | :--------------- | --------------: | ------ |
| 1   | Jens Bergholm    |  Mølletoften 20 | 7100   |
| 2   | Dennis Jørgensen |   Vinkelvej 167 | 7100   |
| 3   | Hans Jensen      | Kongensgrade 45 | 5000   |
| 4   | Anne Johansen    |   Vinkelvej 167 | 7100   |

zip table:

| zip  | name   |
| ---- | ------ |
| 7100 | Vejle  |
| 5000 | Odense |



Products table:

| ID  | Name          | Phone    | Price | Supplier  ID |
| --- | :------------ | -------- | ----- | ------------ |
| 1   | XBOX Oone     | 12341234 | 1800  | 1            |
| 2   | Playstation 4 | 23452345 | 1900  | 2            |
| 3   | PS Vita       | 23452345 | 1500  | 2            |

Suppliers  table:


| ID  | Name      | Phone    |
| --- | :-------- | -------- |
| 1   | Microsoft | 12341234 |
| 2   | Sony      | 23452345 |


Orders table:

| Customer ID | Product ID |
| ----------- | ---------- |
| 1           | 1          |
| 2           | 2          |
| 3           | 1          |
| 3           | 3          |
| 4           | 2          |



# Exercise:


```sql
CREATE TABLE room_types(
   id serial PRIMARY KEY,
   name VARCHAR (50) NOT NULL
);

INSERT INTO room_types (name) VALUES ('Office');
INSERT INTO room_types (name) VALUES ('Normal');
INSERT INTO room_types (name) VALUES ('Two Bed');
INSERT INTO room_types (name) VALUES ('Special');

CREATE TABLE rooms(
   id serial PRIMARY KEY,
   name VARCHAR (50) NOT NULL,
   room_type_id integer NOT NULL REFERENCES room_types (id)
);

INSERT INTO rooms (name, room_type_id) VALUES ('U45', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('U32', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('U186', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('U150', 1);
INSERT INTO rooms (name, room_type_id) VALUES ('R2', 2);
INSERT INTO rooms (name, room_type_id) VALUES ('R4', 3);
INSERT INTO rooms (name, room_type_id) VALUES ('R5', 4);
INSERT INTO rooms (name, room_type_id) VALUES ('R6', 4);

CREATE TABLE positions(
   id serial PRIMARY KEY,
   designation VARCHAR (100) NOT NULL,
   charges_per_hour FLOAT NOT NULL
);

INSERT INTO positions (designation, charges_per_hour) VALUES ('Professor', 5000);
INSERT INTO positions (designation, charges_per_hour) VALUES ('Assistant Professor', 3000);


CREATE TABLE departments(
   id serial PRIMARY KEY,
   name VARCHAR (100) NOT NULL
);

INSERT INTO departments (name) VALUES ('Neurology');
INSERT INTO departments (name) VALUES ('Orthopedic');
INSERT INTO departments (name) VALUES ('ENT/Neurology');
INSERT INTO departments (name) VALUES ('Skin/Orthepoedic');

CREATE TABLE employees(
   id serial PRIMARY KEY,
   name VARCHAR(200) NOT NULL,
   phone INTEGER NOT NULL,
   position_id integer NOT NULL REFERENCES positions (id),
   department_id integer NOT NULL REFERENCES departments (id),
   room_id integer NOT NULL REFERENCES rooms (id)
);

INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Peterson', '12341234', 1, 1, 1);
INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Jensen', '23452345', 1, 2, 2);
INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Poetch', '34563456', 2, 3, 3);
INSERT INTO employees (name, phone, position_id, department_id, room_id) VALUES ('Dr. Neurenheim', '45674567', 2, 4, 4);

CREATE TABLE beds(
   id serial PRIMARY KEY,
   bed_number VARCHAR (50) UNIQUE NOT NULL
);

INSERT INTO beds (bed_number) VALUES ('B1');
INSERT INTO beds (bed_number) VALUES ('B5');
INSERT INTO beds (bed_number) VALUES ('B7');
INSERT INTO beds (bed_number) VALUES ('B8');
INSERT INTO beds (bed_number) VALUES ('B9');

CREATE TABLE patients(
   id serial PRIMARY KEY,
   name VARCHAR (100) NOT NULL,
   phone VARCHAR (50) NOT NULL,
   cpr_number CHAR (11) UNIQUE NOT NULL
);

INSERT INTO patients (name, phone, cpr_number) VALUES ('Jan', '190582-1113', '98769876');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Peter', '300175-2359', '87658765');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Jens', '041298-1257', '76547654');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Ole', '051165-9863', '65436543');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Anna', '260792-1050', '54325432');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Dennis', '150893-1151', '43214321');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Ahmed', '010211-7853', '32103210');
INSERT INTO patients (name, phone, cpr_number) VALUES ('Annika', '051285-8072', '21092109');

CREATE TABLE appointment (
   patient_id integer NOT NULL REFERENCES patients (id),
   assigned_employee_id integer NOT NULL REFERENCES employees (id)
);

INSERT INTO appointment (patient_id, assigned_employee_id) values (3, 1); -- Jens, Dr. Peterson
INSERT INTO appointment (patient_id, assigned_employee_id) values (7, 4); -- Ahmed, Dr. Neurenheim
INSERT INTO appointment (patient_id, assigned_employee_id) values (8, 4); -- Annika, Dr. Neurenheim

CREATE TABLE admissions (
   room_id integer NOT NULL REFERENCES rooms (id),
   bed_id integer NOT NULL REFERENCES beds (id)
) INHERITS (appointment);

INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (1, 5, 1, 1); -- jan, room r2, bed b1, Dr. Peterson
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (2, 5, 1, 1); -- peter, room r2, bed b1, Dr. Peterson
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (4, 5, 1, 2); -- ole, room r2, bed b1, Dr. Jensen
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (3, 6, 2, 2); -- jens, room r4, bed b5, Dr. Jensen
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (5, 6, 3, 2); -- anna, room r4, bed b7, Dr. Jensen
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (1, 7, 4, 3); -- jan, room r5, bed b8, Dr. Poetch
INSERT INTO admissions (patient_id, room_id, bed_id, assigned_employee_id) VALUES (8, 8, 5, 4); -- annika, room r6, bed b9, Dr. Neurenheim

SELECT patients.name, patients.cpr_number, rooms.name, beds.bed_number
FROM admissions
INNER JOIN patients ON admissions.patient_id = patients.id
INNER JOIN beds ON admissions.bed_id = beds.id
INNER JOIN rooms ON admissions.room_id = rooms.id
INNER JOIN employees ON admissions.assigned_employee_id = employees.id
WHERE employees.name = 'Dr. Peterson';
```
