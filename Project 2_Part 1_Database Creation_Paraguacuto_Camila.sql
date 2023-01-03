create database viewerwatch;
use viewerwatch;

create table accounts
(
	account_id char(7) primary key, 
    accountholder_firstname char(50) not null,
    accountholder_lastname char (50) not null,
    birthdate date not null,
	accountholder_email varchar(255) not null,
    billing_address char(20) not null,
    city char(50) not null,
    state char(2) not null,
    postal char(5) not null,
    bank_account char(17) not null,
    phone_number varchar(15)
);

create table profiles
(
	user_name varchar(30) not null,
    user_id char(4) primary key,
    account_id char(7)
);

create table libraries
(
	library_id char(4) primary key not null,
    library_name varchar(90) not null,
    user_id char(4) not null,
    movie_id char(4),
    tvshow_id char(4)
);

create table reviews
(
	review_id varchar(5) primary key not null,
    user_id char(4) not null,
    review_content varchar(1000),
    review_date date not null,
    review_rating decimal(2,1),
	movie_id char(4),
    tvshow_id char(4)
);

create table profile_watches
(
    user_id char(4) not null,
    movie_id char(4),
    tvshow_id char(4)
);    

#done
create table movies
(
	movie_name varchar (180) not null,
    movie_id char(4) not null,
    release_year numeric (4),
    director varchar (75),
    production_company varchar (30),
    movie_genre varchar (20)
);

create table tv_shows
(
	tvshow_name varchar (100) not null,
    tvshow_id char(4) not null,
    release_year numeric (4),
    episodes numeric (4),
    seasons numeric (3),
    director varchar (75),
    production_company varchar (30),
    tvshow_genre varchar (20)
);
drop table accounts;
#inserting data into accounts table
insert into accounts values ('1009492', 'Henry', 'Alvarez', '2005-04-12', 'halvarez@gmail.com', '8341 NW 115th Ct.', 'Miami', 'FL', '33178', '87158338', '3053998246');
insert into accounts values ('8762398', 'Skylar', 'Bell', '1992-02-13', 'sbell@gmail.com', '122 Berkshire St.', 'Boston', 'MA', '02141', '77158338', '3053998245');  
insert into accounts values ('9874042', 'Miles', 'Mehta', '1996-05-02', 'mmehta@gmail.com', '7695 Rosewood Ave', 'El Paso', 'TX', '79930', '67158338', '3053998244');
insert into accounts values ('1009491', 'Jonathan', 'Chavez', '1993-02-26', 'jchavez@gmail.com', '23 Military Avenue', 'Glastonbury', 'CT', '06033', '57158338', '3053998243');
insert into accounts values ('1009490', 'Quinn', 'Xiong', '1982-12-09', 'qxiong@gmail.com', '312 Bohemia Drive', 'Sidney', 'OH', '45365', '47158338', '3053998242');

#insert data into profiles
insert into profiles values ('reviewerhenrythethird', 'H123','1009492');
insert into profiles values ('skylar123', 'S123','8762398');
insert into profiles values ('milesm', 'M123','9874042');
insert into profiles values ('jchavez', 'J123','1009491');
insert into profiles values ('quinnjr', 'Q123','1009490');


#insert data into libraries
insert into libraries values ('QP12', 'sad movies','S123', 'HP54', null);
insert into libraries values ('UP13', 'not sleeping alone','M123', 'MR87', null);
insert into libraries values ('LP17', 'bingeworthy','J123', null, 'F034');
insert into libraries values ('L517', 'bingeworthy','J123', null, 'T033');
insert into libraries values ('UP14', 'not sleeping alone','M123', null, 'I576');

#insert data into reviews
insert into reviews values ('09876', 'S123', 'funny movie', '2022-02-28', '3.5','HP54', null);
insert into reviews values ('12345', 'M123', 'still crying', '2022-04-20', '4.7','MR87', null);
insert into reviews values ('10296','J123', 'all time favorite', '2022-01-27', '5.0', null, 'F034');
insert into reviews values ('48921', 'J123', 'do not watch this with your mom', '2022-03-01','3.7', null, 'T033');
insert into reviews values ('10234', 'M123', 'so fun', '2022-02-28','4.2', null, 'I576');

#insert data into profile watches
insert into profile_watches values ('S123','HP54', null);
insert into profile_watches values ('M123', 'MR87', null);
insert into profile_watches values ('J123', null, 'F034');
insert into profile_watches values ('M123', null, 'T033');
insert into profile_watches values ('UP13', null, 'I576');

#insert data into movies
insert into movies values ('Harry Potter', 'HP54','2001', 'Chris Columbus', 'Warner Bros. Pictures', 'Fantasy');
insert into movies values ('Midsommar','M123', '2019', 'Ari Aster', 'A24', 'Thriller');
insert into movies values ('It', 'I576', '2017', 'Joe Muhmuh', 'Paramount','Horror');
insert into movies values ('Kill Bill', 'K123', '2003', 'Quentin Tarantino','Miramax', 'Action');
insert into movies values ('Bones and All', 'B924','2022', 'Luca Guadanino', 'Warner Bros. Pictures', 'Horror');

#insert data into tv shows F034
insert into tv_shows values ('Friends', 'F034','1990', '236', '8', 'Elon Musk', 'Warner Bros.', 'Sitcom');
insert into tv_shows values ('House of Dragons', 'T033', '2022', '8', '1', 'Kanye West', 'HBO Max', 'Fantasy');
insert into tv_shows values ('The White Lotus', 'W825','2020', '16', '2', 'Donald Trump', 'HBO Max', 'Thriller');
insert into tv_shows values ('South Park', 'S384','2000', '556', '25', 'Paris Hilton', 'Comedy Central', 'Comedy' );
insert into tv_shows values ('Breaking Bad', 'B837','2012', '67','6', 'Joe Biden', 'Netflix', 'Action');
