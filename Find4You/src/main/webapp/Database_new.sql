CREATE database find4u;
USE find4u;
	
CREATE TABLE Users( 
    id int auto_increment primary key,
	first_Name VARCHAR(50) not null,
    last_Name VARCHAR(50) null,
    date_Of_Birth VARCHAR(10) not null,
    email_Id VARCHAR(75) not Null,
    password VARCHAR(30) not null,
    phone_No varchar(10) not null,
    user_status varchar(10) not null default 'open'
    );
    
/*Alter table USERS modify phone_No varchar(10) not null;*/
    
 #INSERT INTO USERS VALUES(0,'Sakthi','B','21-02-2002','sakthi21feb@gmail.com','Sakthi12.','8765220320','open');

CREATE TABLE Artists(
	id int auto_increment primary key,
    first_Name VARCHAR(50) not null,
    last_Name VARCHAR(50)  null,
    date_Of_Birth VARCHAR(10) not null,
    email_Id VARCHAR(75) not Null,
    password VARCHAR(30) not null,
    phone_No varchar(10) not null,
    artist_status varchar(10) not null default 'open'
);
  
# Insert into Artists values('Sakthi','B','21-02-2002','Software Development','sakthi	@gmail.com','Sakthi@12','8765220320','open');

Create table category(
	id int auto_increment primary key,
	category varchar(50) not null,
    artist_Id int not null );



CREATE TABLE Request(
	id int primary key auto_increment,
    user_Id int not null,
    category varchar(50) not null,
	title VARCHAR(50) not null,
    req_Description varchar(200) not null,
    request_Status varchar(8) not null default 'Open',
	post_Time datetime default current_timestamp
    );
    
 # Insert into Request(title,req_Description,category,user_Id,request_Status) values('Need a Developer','There a large number of opening in the sector of IT','Software Development','Sakthi21feb@gmail.com','open');


CREATE TABLE Message(
	id int primary key auto_increment,
    request_Id int not null,
    from_Id int not null,
    to_Id int not null,
    message varchar(200) not null,
    message_Status varchar(8) not null default 'sent',
    post_Time datetime default current_timestamp
);

#Insert into message(artist_Id,user_Id,message,request_Id,message_Status) VALUES('sakthi21feb@gmail.com','user@gmail.com','Hey I would like to work with you',1,'send');

CREATE TABLE Payment(
	id int primary key auto_increment,
    trans_Id varchar(25) not null,
    user_Id int not null,
    payment_Status varchar(10) not null default 'pending',
    payment_Time datetime default current_timestamp
);

    
create table products(
	id int primary key,
    title varchar(50) not null,
    pro_description varchar(200) not null,
    location varchar(100) not null,
    artist_Id int not null,
    product_Status varchar(40) not null,
    posted_time datetime not null default current_timestamp
);
    

Create or replace View Request_Details As 
	select request.id, 
    users.id As User_Id,
    ( select concat(users.first_name," ", 
    users.last_name)) As user_Name, users.email_Id ,
    users.phone_No, request.title,
    request.req_Description, request.category,
    request.request_Status 
    from Users inner join request 
    where request.user_Id = users.id; 
 
Create or replace view message_Details As
	Select request.id,
    users.id as user_Id,
    ( Select concat(users.first_name,' ',users.last_name) )as user_Name,
    users.email_Id as User_email,
    users.phone_No as User_phoneno,
    artists.id as artist_Id,
    ( Select concat(artists.first_name,' ',artists.last_name)) as artist_Name,
    artists.email_Id as Artist_email,
    artists.phone_No as Artist_phoneno,
    request.title,
    request.req_Description,
    request.category,
    request.request_status,
	message.id as message_Id,
	message.message,
    message.message_Status
    from Users inner join request 
    on request.user_Id = users.id
    inner join message 
    on request.id = message.request_Id 
    inner join artists
    on message.from_Id = artists.id 
    Order By message.post_Time;
    

