--1. Показать все книги, количество страниц в которых больше
--500, но меньше 650.
--select * 
--from Books
--where Pages between 500 and 650

--2. Показать все книги, в которых первая буква названия либо
--«А», либо «З».
--select * 
--from Books
--where Name like 'А%' or Name like 'З%'

--3. Показать все книги жанра «Детектив», количество проданных
--книг более 30 экземпляров.
--select * 
--from Books, Themes, Sales
--where Books.ThemeId=Themes.Id and Themes.Name like 'Детектив' and Sales.Quantity > 30

--4. Показать все книги, в названии которых есть слово «Microsoft
--», но нет слова «Windows».
--select * 
--from Books
--where Name like '%Microsoft%' and Name not like '%Windows%'

--5. Показать все книги (название, тематика, полное имя автора
--в одной ячейке), цена одной страницы которых меньше
--65 копеек.
--select Books.Name+'  /  '+Themes.Name+'  /  '+Authors.Surname+' '+Authors.Name as [Книга и автор], (Price/Pages) as [Цена страницы]
--from Books,Themes, Authors
--where Books.ThemeId=Themes.Id and books.AuthorId=Authors.Id and (Price/Pages) < 0.65

--6. Показать все книги, название которых состоит из 4 слов.
--select * 
--from Books
--where Name like '_% _% _% _%' and Name not like '_% _% _% _% _%'

--7. Показать информацию о продажах в следующем виде:
--▷▷Название книги, но, чтобы оно не содержало букву «А».
--▷▷Тематика, но, чтобы не «Программирование».
--▷▷Автор, но, чтобы не «Герберт Шилдт».
--▷▷Цена, но, чтобы в диапазоне от 10 до 20 гривен.
--▷▷Количество продаж, но не менее 8 книг.
--▷▷Название магазина, который продал книгу, но он не
--должен быть в Украине или России.
--select Books.Name as [Название], Themes.Name as [Тематика], Authors.Surname+' '+Authors.Name as [Автор],
--Books.Price as [Цена], Sales.Quantity as [Количество], Shops.Name as [Магазин]
--from Books join Themes on Books.ThemeId=Themes.Id and Books.Name like '%[^А]%' and Themes.Name != 'Программирование'
--			join Authors on Books.AuthorId=Authors.Id and Authors.Surname != 'Шилдт' and Authors.Name != 'Герберт'
--			join Countries on Authors.CountryId=Countries.Id
--			join Sales on Books.Id=Sales.BookId and (Books.Price between 100 and 200) and Sales.Quantity > 8
--			join Shops on Sales.ShopId=Shops.Id and Countries.Name not in ('Украина','Россия')

--8. Показать следующую информацию в два столбца (числа
--в правом столбце приведены в качестве примера):
--▷▷Количество авторов: 14
--▷▷Количество книг: 47
--▷▷Средняя цена продажи: 85.43 грн.
--▷▷Среднее количество страниц: 650.6.
--select 'Количество авторов: ' as [Метрика], cast(count(Authors.Id) as nvarchar(10)) as [Значение] from Authors 
--union all
--select 'Количество книг: ', cast(count(Books.Id) as nvarchar(10)) from Books
--union all
--select 'Средняя цена продажи: ', cast(AVG(Sales.Price) as nvarchar(10))+' грн.' as [sred] from Sales
--union all
--select 'Среднее количество страниц: ', cast(AVG(Books.Pages) as nvarchar(10)) from Books


--9. Показать тематики книг и сумму страниц всех книг по
--каждой из них.
--select Themes.Name as [Тематика], Sum(Pages) as [Страниц в книгах по тематике]
--from Themes, Books
--where Themes.Id=Books.ThemeId
--group by Themes.Name


--10. Показать количество всех книг и сумму страниц этих книг
--по каждому из авторов.
--select Authors.Surname+' '+Authors.Name as [Автор], Sum(Books.Pages) as [Страниц в книгах автора]
--from Authors, Books
--where Authors.Id=Books.AuthorId
--group by Authors.Surname+' '+Authors.Name
--order by Sum(Books.Pages)

--11. Показать книгу тематики «Программирование» с наибольшим
--количеством страниц.
--select Books.Name
--from Books, Themes
--where Pages = (Select max(Pages) from Books where Books.ThemeId=Themes.Id and Themes.Name='Программирование')

--12. Показать среднее количество страниц по каждой тематике,
--которое не превышает 400.
--select Themes.Name as [Тематика], AVG(Pages) as [Среднне число страниц тематикам]
--from Themes, Books
--where Themes.Id=Books.ThemeId
--group by Themes.Name
--HAVING AVG(Pages) < 400

--13. Показать сумму страниц по каждой тематике, учитывая
--только книги с количеством страниц более 400, и чтобы
--тематики были «Программирование», «Администрирование
--» и «Дизайн».
--select Themes.Name as [Тематика], Sum(Pages) as [Страниц в книгах по тематике]
--from Themes, Books
--where Themes.Id=Books.ThemeId and Books.Pages > 400 and Themes.Name in ('Программирование','Администрирование','Дизайн')
--group by Themes.Name

--14. Показать информацию о работе магазинов: что, где, кем,
--когда и в каком количестве было продано.
--select Books.Name as [Название], Countries.Name as [Страна], Shops.Name as [Магазин],  Sales.SaleDate as [Дата продажи], Sales.Quantity as [Количество]
--from Books join Sales on Books.Id=Sales.BookId
--			join Shops on Sales.ShopId=Shops.Id
--			join Countries on Countries.Id=Shops.CountryId


--15. Показать самый прибыльный магазин.
--select Shops.Name as [Магазин]
--from Shops join Sales on Sales.ShopId=Shops.Id
--with PROM as (select Shops.Name, sum(Sales.Quantity*Sales.Price) as [money_sum]
--from Shops join Sales on Sales.ShopId=Shops.Id
--group by Shops.Name)

--select Name as [Магазин], money_sum as [Прибыль] from PROM where money_sum=(select max(money_sum) from PROM)


