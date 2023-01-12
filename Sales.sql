use project_group4;

/*Q1 */
create table Salespeople (snum int, sname char(255), city char(255), comm float);
insert into salespeople values (1001, "Peel","London",0.12), (1002, "Serres","San Jose",0.13), (1003,"Axelrod","New York",0.10), (1004, "Motika","London",0.11), (1007, "Rafkin","Barcelona",0.15);

/*Q2 */
create table Cust (cnum int, cname char(255), city char(255), rating int, snum int);
insert into cust values (2001, "Hoffman", "London", 100, 1001), (2002, "Giovanne", "Rome", 200, 1003), (2003, "Liu", "San Jose", 300, 1002), (2004, "Grass", "Berlin", 100, 1002), (2006, "Clemens", "London", 300, 1007), (2007, "Pereira", "Rome", 100, 1004), (2008, "James", "London", 200, 1007);

/*Q3 */
create table Orders (onum int, amt	float, odate date, cnum int, snum int);
insert into orders values (3001, 18.69, "1994-10-03", 2008, 1007), (3002, 1900.1, "1994-10-03", 2007, 1004), (3003, 767.19, "1994-10-03", 2001, 1001), (3005, 5160.45, "1994-10-03", 2003, 1002), (3006, 1098.16, "1994-10-04", 2008, 1007), (3007, 75.75, "1994-10-05", 2004, 1002), (3008, 4723, "1994-10-05", 2006, 1001), (3009, 1713.23, "1994-10-04", 2002, 1003), (3010, 1309.95, "1994-10-06", 2004, 1002),(3011, 9891.88, "1994-10-06", 2006, 1001);

/*Q4- Write a query to match the salespeople to the customers according to the city they are living. */
select s.sname as Salesperson, c.cname as Customer, s.city from salespeople s join cust c on (s.city=c.city);

/*Q5- Write a query to select the names of customers and the salespersons who are providing service to them */
select c.cname as Customer, s.sname as Salesperson from cust c join salespeople s on (c.snum=s.snum);

/*Q6- Write a query to find out all orders by customers not located in the same cities as that of their salespeople */
select o. onum from orders o join cust c on (o.cnum=c.cnum) where c.cnum in (select c.cnum from cust c left outer join salespeople s on (c.snum=s.snum) where c.city!=s.city);

/*Q7- Write a query that lists each order number followed by name of customer who made that order */
select o.onum as Order_Number, c.cname as Customer from orders o join cust c on (o.cnum=c.cnum);

/*Q8- Write a query that finds all pairs of customers having the same rating */
select c1.cname, c2.cname, c1.rating from cust c1 join cust c2 on (c1.rating=c2.rating) and (c1.cnum<c2.cnum) order by c1.rating;

/*Q9- Write a query to find out all pairs of customers served by a single salesperson */
select c1.cname, c2.cname, s1.sname from (cust c1 join cust c2 on (c1.snum=c2.snum) and (c1.cnum<c2.cnum)) join salespeople s1 on (c1.snum=s1.snum);

/*Q10- Write a query that produces all pairs of salespeople who are living in same city */
select s1.sname, s2.sname, s1.city from salespeople s1, salespeople s2 where s1.city=s2.city and s1.snum<s2.snum;

/*Q11- Write a Query to find all orders credited to the same salesperson who services Customer 2008 */
select onum from orders where snum in (select snum from cust where cnum=2008);

/*Q12- Write a Query to find out all orders that are greater than the average for Oct 4th */
select onum from orders where amt>(select avg(amt) from orders where month(odate)=10 and day(odate)=4);

/*Q13- Write a Query to find all orders attributed to salespeople in London */
select onum from orders where snum in (select snum from salespeople where city="London");

/*Q14- Write a query to find all the customers whose cnum is 1000 above the snum of Serres */
select cname from cust where cnum>(select snum from salespeople where sname="serres")+1000;

/*Q15- Write a query to count customers with ratings above San Jose’s average rating */
select count(cnum) from cust where rating>(select avg(rating) from cust where city="San Jose");

/*Q16- Write a query to show each salesperson with multiple customers */
select sname from salespeople where snum in (select distinct c1.snum from cust c1 join cust c2 on c1.cnum!=c2.cnum and c1.snum=c2.snum);