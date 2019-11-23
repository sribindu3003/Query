use Training_19Sep19_Pune
go

select * from [46008229].Car

create table [46008229].Car
(
Id int primary key identity(1,1),
Model varchar(20) unique,
ManufacturerId int,
TypeId int,
Engine varchar(10),
BHP int,
TransmissionId int,
Mileage int not null,
Seat int not null,
AirBags varchar(20) not null,
BootSpace Varchar(10) not null,
Price decimal not null
)


create table [46008229].Manufacturer
(
Id int primary key identity(1,1),
ManufacturerName Varchar(50) Unique,
ContactPerson varchar(30) unique,
RegisteredOffice varchar(50) not null
)

create table [46008229].CarType
(
Id int primary key identity(1,1),
CarType varchar(10) unique
)

create table [46008229].CarTransmissionType
(
Id int primary key identity(1,1),
TransmissionType varchar(15) unique
)
drop table [46008229].CarLogin

create  table [46008229].CarLogin
(
UserId varchar(50) primary key,
Pwd varchar(50) not null
)

insert into [46008229].CarLogin values ('Sri','sri3003')

-------------------------------stored procedures------------------------------------

create procedure [46008229].AddCar
@Model varchar(20),
@ManName varchar(20),
@Type Varchar(10),
@Engine varchar(4),
@BHP int,
@Transmission varchar(15),
@Mileage int,
@Seat int,
@AirBags varchar(30),
@BootSpace int,
@Price float
as
declare @manId int
select @manId=Id from [46008229].Manufacturer where ManufacturerName=@ManName
declare @TypeId int
select @TypeId=Id from [46008229].CarType where CarType=@Type
declare @TId int 
select @TId=Id from [46008229].CarTransmissionType where TransmissionType=@Transmission
insert into [46008229].Car values(@Model,@manId,@TypeId,@Engine,@BHP,@TId,@Mileage,@Seat,@AirBags,@BootSpace,@Price)
go

create procedure [46008229].DeleteCar
@Model varchar(20)
as
delete from [46008229].Car where Model=@Model
go

create procedure [46008229].UpdateCar
(
@Model varchar(20),
@ManName varchar(20),
@Type Varchar(10),
@Engine varchar(4),
@BHP int,
@Transmission varchar(15),
@Mileage int,
@Seat int,
@AirBags varchar(30),
@BootSpace int,
@Price float
)
as
declare @manId int
select @manId=Id from [46008229].Manufacturer where ManufacturerName=@ManName
declare @TypeId int
select @TypeId=Id from [46008229].CarType where CarType=@Type
declare @TId int 
select @TId=Id from [46008229].CarTransmissionType where TransmissionType=@Transmission
update [46008229].Car set ManufacturerId=@manId,TypeId=@TypeId,Engine=@Engine,BHP=@BHP,TransmissionId=@TId,Mileage=@Mileage,Seat=@Seat,AirBags=@AirBags,BootSpace=@BootSpace,Price=@Price
 where Model=@model
go



create procedure [46008229].SearchCarByModel
@model varchar(100)
as
begin
select Model,ManufacturerName,CarType,Engine,BHP,TransmissionType,Mileage,Seat,AirBags,BootSpace,Price from [46008229].Car C
 inner join [46008229].Manufacturer Man on C.ManufacturerId=Man.Id 
 inner join [46008229].CarType CT on C.TypeId=CT.Id
  inner join [46008229].CarTransmissionType CTT on C.TransmissionId=CTT.Id  
  where C.Model=@model
  end
go


create procedure [46008229].SearchCarByName
(
@name varchar(20),
@CarType varchar(10)
)
as
select ManufacturerName,Model,CarType,Price from [46008229].Car c
 inner join [46008229].Manufacturer man on c.ManufacturerId=man.Id 
 inner join [46008229].CarType ct on c.TypeId=ct.Id
  inner join [46008229].CarTransmissionType ctt on c.TransmissionId=ctt.Id  
  where man.ManufacturerName=@name and ct.CarType=@CarType
 go


 
create procedure [46008229].ListCars
as
select ManufacturerName,Model,CarType,Price from [46008229].Car c
inner join [46008229].Manufacturer man on c.ManufacturerId=man.Id
 inner join [46008229].CarType ct on c.TypeId=ct.Id
 go

 create procedure [46008229].ValidateLogin
 @UserId varchar(20),
 @Pwd varchar(20)
 
 as
 begin
 select * from [46008229].CarLogin where UserId=@UserId and Pwd=@Pwd
 exec  [46008229].ValidateLogin 'Sri','sri3003'
 end 
 go