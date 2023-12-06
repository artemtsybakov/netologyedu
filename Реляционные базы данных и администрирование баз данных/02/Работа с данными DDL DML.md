# Домашнее задание к занятию «Работа с данными (DDL/DML)»

---

Задание можно выполнить как в любом IDE, так и в командной строке.

### Задание 1
1.1. Поднимите чистый инстанс MySQL версии 8.0+. Можно использовать локальный сервер или контейнер Docker.

Установил MySQl.

![My_SQL_install_complete](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/MySQL_install_complete.png)

1.2. Создайте учётную запись sys_temp. 

Создал пользователя. Команда ``` CREATE USER 'sys_temp'@'localhost' IDENTIFIED BY 'qwerty'; ```

1.3. Выполните запрос на получение списка пользователей в базе данных. (скриншот)

Проверка создания пользователя. Команда ``` SELECT USER FROM mysql.user; ```

![create_user](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/create%20user.png)

1.4. Дайте все права для пользователя sys_temp. 

Дал все права пользователю. Командa ``` GRANT ALL ON *.* TO 'sys_temp'@'localhost'; ```

1.5. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

Запрос на получение списка прав. Команда ``` SHOW GRANTS FOR 'sys_temp'@'localhost'; ```

![show_grant_sys_test](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/show%20grant%20sys_test.png)

1.6. Переподключитесь к базе данных от имени sys_temp.

Для смены типа аутентификации с sha2 используйте запрос: 
```sql
ALTER USER 'sys_test'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
```

Настройки подключения в программе dbeaver.

![connection_new_user](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/connection%20new%20user.png)

Подключение прошло успешно.

![connection_new_user2](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/connection%20new%20user2.png)

Проверка текущего пользователя. Команда ``` SELECT USER(); ```

![connection_new_user3](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/connection%20new%20user3.png)

1.6. По ссылке https://downloads.mysql.com/docs/sakila-db.zip скачайте дамп базы данных.

1.7. Восстановите дамп в базу данных.

Восстанавливал БД с помощью dbeaver.

1.8. При работе в IDE сформируйте ER-диаграмму получившейся базы данных. При работе в командной строке используйте команду для получения всех таблиц базы данных. (скриншот)

ER диаграмма
![db_dump_restore](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/img/db%20dump%20restore.png)

[Ссылка на файл с запросами](https://github.com/artemtsybakov/netologyedu/blob/master/%D0%A0%D0%B5%D0%BB%D1%8F%D1%86%D0%B8%D0%BE%D0%BD%D0%BD%D1%8B%D0%B5%20%D0%B1%D0%B0%D0%B7%D1%8B%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85%20%D0%B8%20%D0%B0%D0%B4%D0%BC%D0%B8%D0%BD%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5%20%D0%B1%D0%B0%D0%B7%20%D0%B4%D0%B0%D0%BD%D0%BD%D1%8B%D1%85/02/files/HW2.sql)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*


### Задание 2
Составьте таблицу, используя любой текстовый редактор или Excel, в которой должно быть два столбца: в первом должны быть названия таблиц восстановленной базы, во втором названия первичных ключей этих таблиц. Пример: (скриншот/текст)
```
Название таблицы | Название первичного ключа
customer         | customer_id
```


## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 3*
3.1. Уберите у пользователя sys_temp права на внесение, изменение и удаление данных из базы sakila.

3.2. Выполните запрос на получение списка прав для пользователя sys_temp. (скриншот)

*Результатом работы должны быть скриншоты обозначенных заданий, а также простыня со всеми запросами.*
