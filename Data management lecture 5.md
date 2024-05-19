
# Mapping ER diagrams to SQL code


## Step 1: Mapping of Regular Entity types

- For each regular entity type create a relation (table) that includes all the simple attributes of that entity

## Step 2:  Mapping of Weak Entity types
- For each weak entity type create a relation (table) that includes all simple attributes of the weak entity.  The primary key of the new relation should be the partial key of the weak entity plus the primary key of its owner

## Step 3: Mapping of 1:1 relationship types
- Include one side of the relationship as a foreign key in the other. Favour total participation  

## Step 4: Mapping of 1:N relationship types
- include the 1 side's primary key as a foreign key on the N side relation (table

## Step 5: Mapping of M:N relationship types
- Create a new relation (table) who's primary key is a combination of both entities' primary key's. Also include any relationship attributes.

## Step 6: Mapping of Identifying relationship types (if any)
- In identifying relationships, the child table will have a composite primary key that includes the primary key of the parent table. Create foreign key constraints to establish the relationship between the tables.



### Example

![[Pasted image 20240519154045.png]]


#### Example step 1: Mapping of Regular entities

Employee:

| emp_id | first name | last name | sex | birth_date | salary | age |
| ------ | :--------- | --------- | --- | ---------- | ------ | --- |

Client:

| client_id | first name | last name |
| --------- | :--------- | --------- |

Branch:

| branch_id | branch_name | # of employees |
| --------- | :---------- | -------------- |
#### Example step 2: Mapping of weak entities

Branch supplier:

| branch_id | supplier_name | supply_type |
| --------- | :------------ | ----------- |

#### Step 3: Mapping of 1:1 relationship types

Branch:

| branch_id | branch_name | # of employees | emp_id |
| --------- | :---------- | -------------- | ------ |

#### Step 4: Mapping of 1:N relationship types

Client:

| client_id | first name | last name | branch_id |
| --------- | :--------- | --------- | --------- |

Employee:

| emp_id | fname | surname | sex | birth_date | salary | age | super_id | branch_id |
| ------ | :---- | ------- | --- | ---------- | ------ | --- | -------- | --------- |

#### Step 5: Mapping of M:N relationship types

Works on:

| client_id | emp_id | total_sales |
| --------- | :----- | ----------- |


branch supplier and branch:

| branch_id | branch_supplier_name | supply_type |
| --------- | :------------------- | ----------- |
