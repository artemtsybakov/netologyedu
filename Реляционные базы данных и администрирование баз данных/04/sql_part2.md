# Домашнее задание к занятию «SQL. Часть 2»

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1

Одним запросом получите информацию о магазине, в котором обслуживается более 300 покупателей, и выведите в результат следующую информацию: 
- фамилия и имя сотрудника из этого магазина;
- город нахождения магазина;
- количество пользователей, закреплённых в этом магазине.

```
USE sakila;
```
```
SELECT s.store_id ,
         c.city,
         concat(s2.first_name,' ',s2.last_name),
         count(c2.customer_id)
    FROM store s 
    JOIN staff s2 ON s2.staff_id = s.manager_staff_id 
    JOIN address a ON a.address_id = s.address_id 
    JOIN city c ON a.city_id = c.city_id 
    JOIN customer c2 ON s.store_id = c2.store_id 
GROUP BY s.store_id 
  HAVING count(c2.customer_id) > 300;
```
### Задание 2

Получите количество фильмов, продолжительность которых больше средней продолжительности всех фильмов.

```
SELECT count(f.film_id)
  FROM film f
 WHERE f.length > (
       SELECT sum(f2.length)/count(f2.film_id) 
       FROM film f2)
```
### Задание 3

Получите информацию, за какой месяц была получена наибольшая сумма платежей, и добавьте информацию по количеству аренд за этот месяц.

```
  SELECT month(p.payment_date), count(r.rental_id)
    FROM payment p 
    JOIN rental r ON r.rental_id = p.rental_id 
GROUP BY month(p.payment_date)
ORDER BY sum(p.amount) DESC LIMIT 1;
```
## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 4*

Посчитайте количество продаж, выполненных каждым продавцом. Добавьте вычисляемую колонку «Премия». Если количество продаж превышает 8000, то значение в колонке будет «Да», иначе должно быть значение «Нет».

```
  SELECT s.staff_id, 
         count(p.rental_id) AS "Количество продаж",
         (CASE 
	         WHEN count(p.rental_id) > 8000 THEN 'Да'
	         WHEN count(p.rental_id) < 8000 THEN 'Нет'
         END) AS "Премия"
    FROM staff s  
         INNER JOIN payment p ON p.staff_id = s.staff_id
GROUP BY s.staff_id;
```
### Задание 5*

```
         f.rating AS "Рейтинг",
         c2.name AS "Жанр",
         f.release_year AS "Год выпуска",
         l.name AS "Язык", 
         count(r.rental_id) AS "Количество аренд",
         sum(p.amount) AS "Общая стоимость аренды"
    FROM film f
         LEFT JOIN inventory i ON i.film_id = f.film_id 
         LEFT JOIN rental r ON r.inventory_id = i.inventory_id
         LEFT JOIN customer c ON c.customer_id = r.inventory_id
         LEFT JOIN payment p ON p.rental_id = r.rental_id
         INNER JOIN film_category fc ON fc.film_id = f.film_id 
         INNER JOIN category c2 ON c2.category_id = fc.category_id 
         INNER JOIN language l ON l.language_id = f.language_id 
GROUP BY f.film_id, c2.category_id, l.language_id
HAVING count(r.rental_id) = 0 
ORDER BY f.title;
```
Найдите фильмы, которые ни разу не брали в аренду.
