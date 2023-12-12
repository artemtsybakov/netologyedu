# Домашнее задание к занятию «SQL. Часть 1»

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Получите уникальные названия районов из таблицы с адресами, которые начинаются на “K” и заканчиваются на “a” и не содержат пробелов.
```
USE sakila;
```

```
SELECT DISTINCT a.district
  FROM address a
 WHERE a.district LIKE 'K%a'
   AND a.district NOT LIKE '% %';
```

### Задание 2

Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись в промежуток с 15 июня 2005 года по 18 июня 2005 года **включительно** и стоимость которых превышает 10.00.

```
SELECT p.amount, 
	   p.payment_date
  FROM payment p 
 WHERE p.amount > 10
   AND CAST(p.payment_date AS DATE) BETWEEN '2005/06/15'
   AND '2005/06/18';
```

### Задание 3

Получите последние пять аренд фильмов.

```
  SELECT *
    FROM rental r 
ORDER BY r.rental_date DESC  
   LIMIT 5;
```

### Задание 4

Одним запросом получите активных покупателей, имена которых Kelly или Willie. 

Сформируйте вывод в результат таким образом:
- все буквы в фамилии и имени из верхнего регистра переведите в нижний регистр,
- замените буквы 'll' в именах на 'pp'.

```
SELECT LOWER(last_name) AS last_name,
	   REPLACE(LOWER(first_name), 'll', 'pp') AS first_name, 
	   active
  FROM customer
 WHERE active = 1 
   AND (first_name = 'WILLIE' OR first_name = 'KELLY');
```

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 5*

Выведите Email каждого покупателя, разделив значение Email на две отдельных колонки: в первой колонке должно быть значение, указанное до @, во второй — значение, указанное после @.

```
SELECT c.customer_id,
       c.email,
       SUBSTRING_INDEX(c.email, '@', 1) AS "Email before @",
       SUBSTRING_INDEX(c.email, '@', -1) AS "Email after @"
FROM customer c;
```

### Задание 6*

Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: первая буква должна быть заглавной, остальные — строчными.

```
SELECT c.customer_id,
       c.email,
       SUBSTRING_INDEX(CONCAT(UPPER(LEFT(c.email, 1)),LOWER(SUBSTRING(c.email, 2))), '@', 1) AS "Email before @",
       CONCAT(UPPER(LEFT(SUBSTRING_INDEX(c.email, '@', -1), 1)), SUBSTRING(SUBSTRING_INDEX(c.email, '@', -1), 2)) AS "Email after @"
FROM customer c; 
```