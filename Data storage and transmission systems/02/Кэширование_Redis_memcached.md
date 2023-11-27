# Домашнее задание к занятию «`Кеширование Redis/memcached`» - `Цыбаков Артём`

### Инструкция по выполнению домашнего задания

1. Сделайте fork [репозитория c шаблоном решения](https://github.com/netology-code/sys-pattern-homework) к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/gitlab-hw или https://github.com/имя-вашего-репозитория/8-03-hw).
2. Выполните клонирование этого репозитория к себе на ПК с помощью команды `git clone`.
3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
   - впишите вверху название занятия и ваши фамилию и имя;
   - в каждом задании добавьте решение в требуемом виде: текст/код/скриншоты/ссылка;
   - для корректного добавления скриншотов воспользуйтесь инструкцией [«Как вставить скриншот в шаблон с решением»](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md);
   - при оформлении используйте возможности языка разметки md. Коротко об этом можно посмотреть в [инструкции по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md).
4. После завершения работы над домашним заданием сделайте коммит (`git commit -m "comment"`) и отправьте его на Github (`git push origin`).
5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
6. Любые вопросы задавайте в чате учебной группы и/или в разделе «Вопросы по заданию» в личном кабинете.

Желаем успехов в выполнении домашнего задания.

---

### Задание 1. Кеширование 

Приведите примеры проблем, которые может решить кеширование. 

*Приведите ответ в свободной форме.*

```Пользователи поисковой системы часто запрашивают одни и те же данные. Что бы каждый раз не выгружать эти данные из базы, они помещаются в кэш. Как правило в область быстрой памяти. Следующий раз, когда кто-то снова запросит эти данные, они будт пререданы пользователю из кэша. Кэширование может увеличить скорость досупа к часто используемым данным.```

---

### Задание 2. Memcached

Установите и запустите memcached.


*Приведите скриншот systemctl status memcached, где будет видно, что memcached запущен.*

`sudo apt install memcached`

`sudo systemctl status memcached`

![staus](https://github.com/artemtsybakov/netologyedu/blob/master/Data%20storage%20and%20transmission%20systems/02/img/memcached_status.jpg)

---

### Задание 3. Удаление по TTL в Memcached

Запишите в memcached несколько ключей с любыми именами и значениями, для которых выставлен TTL 5. 

*Приведите скриншот, на котором видно, что спустя 5 секунд ключи удалились из базы.*

```
telnet localhost 11211
set name 0 5 3
abc
STORED
get name
VALUE name 0 3
abc
END
```

![values](https://github.com/artemtsybakov/netologyedu/blob/master/Data%20storage%20and%20transmission%20systems/02/img/memcached.jpg)

---

### Задание 4. Запись данных в Redis

Запишите в Redis несколько ключей с любыми именами и значениями. 

*Через redis-cli достаньте все записанные ключи и значения из базы, приведите скриншот этой операции.*

![redis_indstalled](https://github.com/artemtsybakov/netologyedu/blob/master/Data%20storage%20and%20transmission%20systems/02/img/redis.jpg)

```
set name Boris
set name1 Artem
set name2 Sergey
keys *
get name
get name1
get name2
```

![values_redis](https://github.com/artemtsybakov/netologyedu/blob/master/Data%20storage%20and%20transmission%20systems/02/img/redis_add_value.jpg)

---

## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже разобраться в материале.

### Задание 5*. Работа с числами 

Запишите в Redis ключ key5 со значением типа "int" равным числу 5. Увеличьте его на 5, чтобы в итоге в значении лежало число 10.  

```
set key5 5 
incrby key5 5
```
![incrby](https://github.com/artemtsybakov/netologyedu/blob/master/Data%20storage%20and%20transmission%20systems/02/img/redis_incrby.jpg)

*Приведите скриншот, где будут проделаны все операции и будет видно, что значение key5 стало равно 10.*