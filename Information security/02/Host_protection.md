# Домашнее задание к занятию "`«Защита хоста»`" - `Цыбаков Артём`

### Задание 1

1. Установите **eCryptfs**.
2. Добавьте пользователя cryptouser.
3. Зашифруйте домашний каталог пользователя с помощью eCryptfs.

*В качестве ответа  пришлите снимки экрана домашнего каталога пользователя с исходными и зашифрованными данными.* 

Установил программу.

Добавил пользователя.

![add_cryptouser](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/1add_cryptouser.png)

Создал файл внутри домашнего католога.

![touch_file](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/2touch_file.png)

Шифрование домашнего каталога.

![home_folder](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/3home_folder.png)

Проверка котдоваой фразы.

![check_passhrase](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/4check_passhrase.png)

Проверка каталока от имени другого пользователя.

![check_home](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/5check_home.png)

---

### Задание 2

1. Установите поддержку **LUKS**.
2. Создайте небольшой раздел, например, 100 Мб.
3. Зашифруйте созданный раздел с помощью LUKS.

*В качестве ответа пришлите снимки экрана с поэтапным выполнением задания.*

Новый диск на 105 мб.

![new_disk](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/6new_disk.png)

Установка и проверка программы.

![check_LUKS](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/7check_LUKS.png)

Подготовка раздела.

![luks_format](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/8luks_format.png)

Проверка после шифрования.

![check_partition](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/9check_partition.png)

Проврка в другой программе.

![check_partition](https://github.com/artemtsybakov/netologyedu/blob/master/Information%20security/02/img/10check_partition.png)

---