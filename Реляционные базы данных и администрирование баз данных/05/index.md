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
                sum(p.amount) over (partition by c.customer_id)
  from payment p 
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

Подключил все таблицы и в оконной функции убрал группировку по фильму.

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 3*

Самостоятельно изучите, какие типы индексов используются в PostgreSQL. Перечислите те индексы, которые используются в PostgreSQL, а в MySQL — нет.

*Приведите ответ в свободной форме.*
