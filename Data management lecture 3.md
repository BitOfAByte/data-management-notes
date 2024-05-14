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
