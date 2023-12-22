# Домашнее задание к занятию «Индексы»

### Задание 1

Напишите запрос к учебной базе данных, который вернёт процентное отношение общего размера всех индексов к общему размеру всех таблиц.

```sql
select sum(INDEX_LENGTH)/sum(DATA_LENGTH)*100
  from information_schema.tables
 where table_schema = 'sakila' 
       and TABLE_TYPE = 'BASE TABLE';
```

### Задание 2

Выполните explain analyze следующего запроса:
```sql
select distinct concat(c.last_name, ' ', c.first_name), sum(p.amount) over (partition by c.customer_id, f.title)
from payment p, rental r, customer c, inventory i, film f
where date(p.payment_date) = '2005-07-30' and p.payment_date = r.rental_date and r.customer_id = c.customer_id and i.inventory_id = r.inventory_id
```
- перечислите узкие места;
- оптимизируйте запрос: внесите корректировки по использованию операторов, при необходимости добавьте индексы.

```sql
select distinct concat(c.last_name, ' ', c.first_name), 
                sum(p.amount) over (partition by c.customer_id )
  from  payment p 
        join rental r on r.rental_id = p.rental_id
        join customer c on c.customer_id = r. customer_id 
        join inventory i on i.inventory_id = r.inventory_id 
        join film f on f.film_id = i.film_id
 where date(p.payment_date) = '2005-07-30' 
       and p.payment_date = r.rental_date 
       and r.customer_id = c.customer_id 
       and i.inventory_id = r.inventory_id;
```
Таблица film была не подключена и каждый раз перебирались все записи из этой таблицы. 

---

### Работа над ошибками

Изменил фильтр. Убрал ненужные условия.

```sql
select distinct concat(c.last_name, ' ', c.first_name), 
                sum(p.amount) over (partition by c.customer_id, f.title)
  from payment p 
       join rental r on r.rental_id = p.rental_id
       join customer c on c.customer_id = r. customer_id 
       join inventory i on i.inventory_id = r.inventory_id 
       join film f on f.film_id = i.film_id
 where payment_date >= ‘2005-07-30’ and payment_date < DATE_ADD(‘2005-07-30’, INTERVAL 1 DAY);
``` 
explain analyze запроса

-> Limit: 1000 row(s)  (cost=0..0 rows=0) (actual time=44.3..44.6 rows=599 loops=1)
    -> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=44.3..44.5 rows=599 loops=1)
        -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=44.3..44.3 rows=599 loops=1)
            -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=37.7..43.5 rows=634 loops=1)
                -> Sort: c.customer_id, f.title  (actual time=37.7..38 rows=634 loops=1)
                    -> Stream results  (cost=4240 rows=1833) (actual time=0.141..36.7 rows=634 loops=1)
                        -> Nested loop inner join  (cost=4240 rows=1833) (actual time=0.133..35.4 rows=634 loops=1)
                            -> Nested loop inner join  (cost=3599 rows=1833) (actual time=0.124..32.9 rows=634 loops=1)
                                -> Nested loop inner join  (cost=2957 rows=1833) (actual time=0.116..30.8 rows=634 loops=1)
                                    -> Nested loop inner join  (cost=2316 rows=1833) (actual time=0.106..29.1 rows=634 loops=1)
                                        -> Filter: ((p.payment_date >= TIMESTAMP'2005-07-30 00:00:00') and (p.payment_date < <cache>(('2005-07-30' + interval 1 day))) and (p.rental_id is not null))  (cost=1674 rows=1833) (actual time=0.0544..26.4 rows=634 loops=1)
                                            -> Table scan on p  (cost=1674 rows=16500) (actual time=0.0444..19.7 rows=16044 loops=1)
                                        -> Single-row index lookup on r using PRIMARY (rental_id=p.rental_id)  (cost=0.25 rows=1) (actual time=0.00376..0.00382 rows=1 loops=634)
                                    -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.25 rows=1) (actual time=0.00237..0.00243 rows=1 loops=634)
                                -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.25 rows=1) (actual time=0.00287..0.00293 rows=1 loops=634)
                            -> Single-row index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.25 rows=1) (actual time=0.00337..0.00344 rows=1 loops=634)

Таблица фильтруется перебором ('Table scan on p').

Проверяю индексы в таблицы payment
```sql
select *
  from information_schema.statistics
 where table_name='payment';
```
![]()
Добавляю иднекс даты в таблицу payment
```sql
create index payment_date on payment(payment_date);
```
![]()
Проверяю explain analyze запроса 

-> Limit: 1000 row(s)  (cost=0..0 rows=0) (actual time=23.5..23.9 rows=599 loops=1)
    -> Table scan on <temporary>  (cost=2.5..2.5 rows=0) (actual time=23.5..23.8 rows=599 loops=1)
        -> Temporary table with deduplication  (cost=0..0 rows=0) (actual time=23.5..23.5 rows=599 loops=1)
            -> Window aggregate with buffering: sum(payment.amount) OVER (PARTITION BY c.customer_id,f.title )   (actual time=16.7..22.8 rows=634 loops=1)
                -> Sort: c.customer_id, f.title  (actual time=16.6..16.9 rows=634 loops=1)
                    -> Stream results  (cost=1173 rows=634) (actual time=0.0737..15.3 rows=634 loops=1)
                        -> Nested loop inner join  (cost=1173 rows=634) (actual time=0.0675..14 rows=634 loops=1)
                            -> Nested loop inner join  (cost=951 rows=634) (actual time=0.0604..11.3 rows=634 loops=1)
                                -> Nested loop inner join  (cost=729 rows=634) (actual time=0.0547..9.07 rows=634 loops=1)
                                    -> Nested loop inner join  (cost=507 rows=634) (actual time=0.0472..6.3 rows=634 loops=1)
                                        -> Filter: (p.rental_id is not null)  (cost=286 rows=634) (actual time=0.0377..3.56 rows=634 loops=1)
                                            -> Index range scan on p using payment_date over ('2005-07-30 00:00:00' <= payment_date < '2005-07-31 00:00:00'), with index condition: ((p.payment_date >= TIMESTAMP'2005-07-30 00:00:00') and (p.payment_date < <cache>(('2005-07-30' + interval 1 day))))  (cost=286 rows=634) (actual time=0.0369..3.4 rows=634 loops=1)
                                        -> Single-row index lookup on r using PRIMARY (rental_id=p.rental_id)  (cost=0.25 rows=1) (actual time=0.00383..0.00389 rows=1 loops=634)
                                    -> Single-row index lookup on c using PRIMARY (customer_id=r.customer_id)  (cost=0.25 rows=1) (actual time=0.00391..0.00397 rows=1 loops=634)
                                -> Single-row index lookup on i using PRIMARY (inventory_id=r.inventory_id)  (cost=0.25 rows=1) (actual time=0.00302..0.00309 rows=1 loops=634)
                            -> Single-row index lookup on f using PRIMARY (film_id=i.film_id)  (cost=0.25 rows=1) (actual time=0.0037..0.00377 rows=1 loops=634)

Время выполнения сократилось с actual time=44.3..44.6 до actual time=23.5..23.9 . Для фильтрации используется созданный индекс ('Index range scan on p'). 

Вурнул назад группировку по фильму. 

Группировку убирал потому что исходный запрос возвращал ФИО и сумму потраченную клинетом на фильмы. Если оставить группировку по фильму в измененном запросе, то он показывает несколько фильмов и результат от исходного отличается.
Результат после исправления
![]()
Результат до исправления
![]()
## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 3*

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.

*Приведите ответ в свободной форме.*
