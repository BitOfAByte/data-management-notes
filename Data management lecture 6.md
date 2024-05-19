
# Functions in postgreSQL

## Was to concat

```sql
|| ' ' ||
```


```sql
concat(<var>, <seperator>, <var>....)
```

```sql
concat_ws(<seperator>, <var>, <var> ....)
```


```sql
create or replace function fnMakeFull(firstName varchar, lastName varchar)
returns varchar
as
$$
begin
    if firstName is null and lastName is null then
        return null;
    elsif firstName is null and lastName is not null then
        return lastName;
    elsif firstName is not null and lastName is null then
        return firstName;
    else
        return concat_{ws(' ', firstName, lastName)
    end if;
end;
$$
language plpgsql;


select * from fnMakeFull('John', 'Doe');
```


## Run queries

```sql
create or replace function fnGetMoviesByYear(yr int)
returns table (
	movie_id int,
	movie_name varchar(60),
	year_released int
)

as 
$$
begin
	return query 
		select m.movie_id, m.movie_name, m.year_released from movies m
		where m.year_released = yr;
end
$$
language plpgsql;

select * from fnGetMoviesByYear(2001);
```


# Transactions


```sql
create table if not exists HREmployee (
	emp_id int not null,
	annual_salary numeric not null,
	salary numeric generated always as (annual_salary/2080) stored
);

begin transaction;

	insert into HREmployee(emp_id, annual_salary) values (1, 400000);
	insert into HREmployee(emp_id, annual_salary) values (2, 400000);
	insert into HREmployee(emp_id, annual_salary) values (3, 400000);
	insert into HREmployee(emp_id, annual_salary) values (4, 400000);
	savepoint test_1;
	
	
	update HREmployee set annual_salary = 200000 where emp_id=2;
	update HREmployee set annual_salary = 100000 where emp_id=3;
	update HREmployee set annual_salary = 50000 where emp_id=4;
	savepoint test_2;
	rollback to savepoint test_1;
	release savepoint test_2;
	commit



select * from HREmployee;

truncate table HREmployee;
```

### Keywords
	- `truncate` drops data in the table
	- `commit` commits the data in a transaction to a table
	- `savepoint` creates a savepoint so you can go back to the working "branch"
	- `rollback` rolls back to the provided savepoint
	- `release` deletes safepoint



# Triggers

```sql
create or replace function fn_calculateSalary()
returns trigger as $$
begin
    new.salary := new.hourly_pay * 2080;
    return new;
end;
$$ language plpgsql

create or replace trigger before_hourly_pay_update
	before update on Employee for each row execute function fn_calculateSalary();

update Employee set hourly_pay = 20;


```



### Exercise 
![[Pasted image 20240519150112.png]]
- Create the SQL implementation of the above ER diagram
	- All creation of tables and inserts must be inside of a transaction, to ensure that it will only be created if everything works
		- Remember to ROLLBACK or COMMIT to ensure you are not caught in a nested BEGIN.
		- If caught, restart the PostgreSQL server.


```sql
begin

create table Employee (
	id serial not null primary key,
	username varchar not null unique,
	password varchar not null,
	email varchar not null
);

create index email_index on Employee (email);

insert into Employee (username, password, email) values 
	('John', 'myPassW0rd', 'john@acme.com'), 
	('Anne', 'myPassW0rd', 'anne@acme.com'), 
	('Jane', 'myPassW0rd', 'jane@acme.com');

create table Departments(
   id serial primary key,
   name varchar (50) unique not null,
   number_of_members integer
);


insert into Departments (name) values ('Sales');

create table department_members (
	emp_id int not null references Employee(id),
	department_id int not null references Department(id)
	primary key(emp_id, department_id)
);

CREATE OR REPLACE PROCEDURE update_department_size(department_number INTEGER)
AS $$
DECLARE
    number_of_department_members integer := 0;
BEGIN
    SELECT COUNT(*) INTO number_of_department_members FROM department_members WHERE department_id = department_number;
    UPDATE departments SET number_of_members = number_of_department_members WHERE id = department_number;
END; $$
LANGUAGE plpgsql;

-- update all departments procedure
CREATE OR REPLACE PROCEDURE update_all_department_sizes()
AS $$
DECLARE
    departments CURSOR FOR SELECT DISTINCT(id) AS id FROM departments;
BEGIN
    FOR department in departments LOOP
        CALL update_department_size(department.id);
    END LOOP;
END; $$
LANGUAGE plpgsql;

-- function wrapper to enable running procedure as trigger
CREATE OR REPLACE FUNCTION update_all_department_sizes_trigger()
    RETURNS TRIGGER
AS $$
BEGIN
    CALL update_all_department_sizes();
    RETURN NULL;
END; $$
LANGUAGE plpgsql;

-- Define trigger to update departments(number_of_members)
CREATE TRIGGER update_number_of_members_trigger
    AFTER INSERT OR DELETE ON department_members
    EXECUTE PROCEDURE update_all_department_sizes_trigger();

-- Commit all changes to the databaqse
COMMIT;

select * from departments; -- number of members is 0

INSERT INTO department_members (employee_id, department_id) VALUES (1,1);
select * from departments; -- number of members is now 1

INSERT INTO department_members (employee_id, department_id) VALUES (2,1);
select * from departments; -- number of members is now 2

INSERT INTO department_members (employee_id, department_id) VALUES (3,1);
select * from departments; -- number of members is now 3

DELETE FROM department_members WHERE department_id = 1;
select * from departments; -- number of members is now 0

```
