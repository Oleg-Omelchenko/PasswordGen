--create database [BookShop]; 
--go
--use [BookShop];
--go

create table Authors
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Surname] nvarchar(max) not null check ([Surname] <> N''),
	[CountryId] int not null
);  

create table Books
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[Pages] int not null check ([Pages] > 0),
	[Price] money not null check ([Price]>=0),
	[PublishDate] date not null check ([PublishDate]<=getdate()),
	[AuthorId] int not null,
	[ThemeId] int not null
); 
create table Countries
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(50) not null unique check ([Name] <> N'')
); 
create table Sales
(
	[Id] int not null identity(1, 1) primary key,
	[Price] money not null check ([Price]>=0),
	[Quantity] int not null check ([Quantity] > 0),
	[SaleDate] date not null check ([SaleDate]<=getdate()) default getdate(),
	[BookId] int not null,
	[ShopId] int not null
); 

create table Shops
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(max) not null check ([Name] <> N''),
	[CountryId] int not null
); 

create table Themes
(
	[Id] int not null identity(1, 1) primary key,
	[Name] nvarchar(100) not null unique check ([Name] <> N'')
); 

alter table Authors
add foreign key (CountryId) references Countries([Id]); 
alter table Books
add foreign key ([AuthorId]) references Authors([Id]); 
alter table Books
add foreign key ([ThemeId]) references Themes([Id]); 
alter table Sales
add foreign key ([BookId]) references Books([Id]); 
alter table Sales
add foreign key ([ShopId]) references Shops([Id]); 
alter table Shops
add foreign key (CountryId) references Countries([Id]); 


 
insert into  Countries ([Name])
VALUES  
('Белоруссия'),('Бельгия'),('Латвия'),('Литва'),('Молдавия'),('Польша'),('Россия'),('Румыния'),('Сербия'),('Словакия'),('Словения'),('Украина'),('Финляндия'),('Эстония'),('США'),('Великобритания');
go

insert into Themes ([Name])
VALUES  
('Программирование'),('Администрирование'),('Дизайн'),('Детектив'),('Фантастика'),('Деловая литература'),('Наука'),('Энциклопедии и справочники'),('Классики литературы'),('Приключения');
go

insert into Shops([Name],[CountryId])
VALUES 
('Белкнига',1),('Книжная Нора',1),('Дом Книги',7),('Буквоед',7),('Свои книги',7),('Буква',12),('Ruslania',13),('Mladinska Knjiga Trgovina',11);
go

insert into  Authors ([Name],[Surname],[CountryId])
VALUES 
('Герберт','Шилдт',15),('Алексей','Чекмарев',7),('Андрей','Попов',7),('Александр','Кенин',12),('Денис','Колисниченко',1),
('Иоханнес','Иттен',4),('Стив','Круг',14),('Дональд','Норман',5),('Агата','Кристи',16),('Грэм','Грин',13),
('Михаил','Булгаков',7),('Николай','Гоголь',12),('Александр','Дюма',16),('Джек','Лондон',16),('Кир','Булычев',7);
go

insert into  Books ([Name],[Pages],[Price],[PublishDate],[AuthorId],[ThemeId])
VALUES
('Java: методики программирования Шилдта',512,405.02,'2008-01-01',1,1),
('Справочник программиста по C/C++',432,1032.45,'2006-02-25',1,1),
('C++: методики программирования Шилдта',480,360.00,'2008-12-30',1,1),
('Полный справочник по C++',624,390.97,'2012-07-07',1,8),
('Windows 7 в домашней сети',240,125.25,'2011-06-27',2,2),
('Microsoft Windows 7. Руководство администратора',315,87.99,'2010-09-01',2,2),
('Переход на Windows 7 с предыдущих версий', 117,100.00,'2010-11-06',2,2),
('Администрирование серверов и доменов',543,1045.35,'2019-10-19',2,2),
('ВВЕДЕНИЕ В WINDOWS POWERSHELL',531,191.99,'2009-09-09',3,2),
('Самоучитель системного администратора',821,1099.99,'2016-10-16',4,2),
('Серверное применение Linux',270,263.01,'2011-11-11',5,6),
('Искусство цвета',255,679.09,'2020-02-20',6,7),
('Веб-дизайн, или Не заставляйте меня думать! : книга Стива Круга',333,1065.50,'2018-08-08',7,3),
('Дизайн привычных вещей',93,199.99,'2011-11-12',8,3),
('Десять негритят',256,168.89,'1939-11-06',9,4),
('Третий',231,245.45,'1950-05-05',10,4),
('Мастер и Маргарита',267,160.00,'1929-01-29',11,9),
('Мёртвые души',79,150.02,'1842-04-18',12,9),
('Граф Монте-Кристо',495,689.99,'1844-04-19',13,9),
('Морской волк',187,265.00,'1904-07-29',14,10),
('Приключения Алисы',374,473.44,'2003-03-03',15,10);
go

insert into Sales ([ShopId],[BookId],[Quantity],[Price],[SaleDate])
VALUES
(1,1,5,507,'2021-12-12'),(1,2,4,1290,'2021-12-12'),(1,3,6,450,'2021-11-11'),(1,4,2,470,'2021-05-02'),(1,5,1,157,'2021-10-15'),
(1,8,1,1307,'2021-09-30'),(1,12,3,850,'2021-07-25'),(1,13,2,1331.25,'2021-06-22'),(1,15,15,199,'2021-05-12'),(1,16,10,300,'2021-09-13'),
(1,17,8,173,'2022-01-01'),(2,6,4,509,'2021-10-31'),(2,7,4,150,'2021-11-16'),(2,8,3,1305,'2021-12-17'),(2,9,3,213,'2021-12-19'),
(2,10,2,1375,'2021-12-20'),(2,11,1,350,'2021-06-19'),(2,14,22,115,'2021-07-07'),(2,18,32,95,'2021-08-27'),(2,19,6,620,'2021-09-29'),
(2,20,2,204,'2022-01-16'),(3,21,5,485,'2021-12-12'),(3,2,4,1290,'2021-12-12'),(3,3,6,450,'2021-11-11'),(3,4,2,470,'2021-05-02'),(3,5,1,157,'2021-10-15'),
(4,8,1,1307,'2021-09-30'),(4,12,3,850,'2021-07-25'),(5,13,2,1331.25,'2021-06-22'),(5,15,15,199,'2021-05-12'),(5,16,10,300,'2021-09-13'),
(6,17,8,173,'2022-01-01'),(6,6,4,509,'2021-10-31'),(6,7,4,150,'2021-11-16'),(6,8,3,1305,'2021-12-17'),(7,9,3,213,'2021-12-19'),
(8,10,7,1375,'2021-12-20'),(8,11,1,350,'2021-06-19'),(7,14,22,115,'2021-07-07'),(7,18,32,95,'2021-08-27'),(6,19,6,620,'2021-09-29');
go

