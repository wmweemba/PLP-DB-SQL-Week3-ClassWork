use salesdb;

create table accounts(
user_id int primary key,
bal int
);

start transaction;
insert into accounts(user_id, bal)
values (1, 1000);
update accounts
set bal=bal-100
where user_id=1;
commit;

start transaction;
insert into accounts(user_id, bal)
values (2, 500);
update accounts
set bal=bal-500
where user_id=2;
commit;

-- A roll back transaction can be used to reverse a mistake made previously
start transaction;
insert into accounts(user_id, bal)
values (3, 500);
update accounts
set bal=bal-1000
where user_id=3;
rollback;

-- Users table
create table users(
user_id int primary key,
username varchar(100) unique,
email varchar(100) unique,
age int check(age > 18)
);

-- This insert will fail because it does not meet the requirement on age to be greater than 18
insert into users(user_id,username,email,age)
values(1,"simmy","simmy@gmail.com",18);

-- What does this code do?
set session transaction isolation level read committed;
start transaction;
insert into accounts(user_id, bal)
values (4, 4500);
update accounts
set bal=bal-100
where user_id=4;
commit;

/* write a query to group order status from the orders table
*/
select status 
from orders
group by status;

/* SUM function combined with group by. We pull out the sum of all check numbers that are less than 10,000. 
here amt is an alias used as a placeholder or variable. HAVING can only be used together with the group by clause */

select checkNumber,SUM(amount) as amt
from payments
group by checkNumber
having amt < 10000;


select orderNumber, SUM(quantityOrdered * priceEach) as total
from orderdetails
group by orderNumber
having total <= 5000;
