
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
