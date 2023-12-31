# Домашнее задание к занятию 2 "`«Кластеризация и балансировка нагрузки»`" - `Цыбаков Артём`

### Цели задания
 В результате выполнения этого задания вы научитесь:
 1. Настраивать балансировку с помощью HAProxy
 2. Настраивать связку HAProxy + Nginx

### Чеклист готовности к домашнему заданию

 1. Установлена операционная система Ubuntu на виртуальную машину и имеется доступ к терминалу
 2. Просмотрены конфигурационные файлы, рассматриваемые на лекции, которые находятся по [ссылке](2/)


### Инструкция по выполнению домашнего задания

 1. Сделайте fork [репозитория c шаблоном решения](https://github.com/netology-code/sys-pattern-homework) к себе в Github и переименуйте его по названию или номеру занятия, например, https://github.com/имя-вашего-репозитория/gitlab-hw или https://github.com/имя-вашего-репозитория/8-03-hw).
 2. Выполните клонирование этого репозитория к себе на ПК с помощью команды git clone.
 3. Выполните домашнее задание и заполните у себя локально этот файл README.md:
   - впишите вверху название занятия и ваши фамилию и имя;
   - в каждом задании добавьте решение в требуемом виде: текст/код/скриншоты/ссылка;
   - для корректного добавления скриншотов воспользуйтесь инструкцией [«Как вставить скриншот в шаблон с решением»](https://github.com/netology-code/sys-pattern-homework/blob/main/screen-instruction.md);
   - при оформлении используйте возможности языка разметки md. Коротко об этом можно посмотреть в [инструкции по MarkDown](https://github.com/netology-code/sys-pattern-homework/blob/main/md-instruction.md).
 4. После завершения работы над домашним заданием сделайте коммит (git commit -m "comment") и отправьте его на Github (git push origin).
 5. Для проверки домашнего задания преподавателем в личном кабинете прикрепите и отправьте ссылку на решение в виде md-файла в вашем Github.
 6. Любые вопросы задавайте в чате учебной группы и/или в разделе «Вопросы по заданию» в личном кабинете.

### Задание 1

<details>
  <summary>Текст задания</summary>  

 - Запустите два simple python сервера на своей виртуальной машине на разных портах
 - Установите и настройте HAProxy, воспользуйтесь материалами к лекции по [ссылке](2/)
 - Настройте балансировку Round-robin на 4 уровне.
 - На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy.

 </details>

<i>

Первый сервер

![simple_python1](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/simple_python_1.png)

Второй сервер

![simple_python2](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/simple_python_2.png)

[Конфигурация для первого задания(tcp)](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/task1_tcp_haproxy.cfg)

Результат выполнения

![haproxy_tcp](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/haproxy_tcp.png)

![Stats](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/stats_haproxy_tcp.png)

</i>

---

### Задание 2

<details>
  <summary>Текст задания</summary>

 - Запустите три simple python сервера на своей виртуальной машине на разных портах
 - Настройте балансировку Weighted Round Robin на 7 уровне, чтобы первый сервер имел вес 2, второй - 3, а третий - 4
 - HAproxy должен балансировать только тот http-трафик, который адресован домену example.local
 - На проверку направьте конфигурационный файл haproxy, скриншоты, где видно перенаправление запросов на разные серверы при обращении к HAProxy c использованием домена example.local и без него.

 </details>

<i>

Третий сервер

![simple_python3](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/simple_python_3.png)

[Конфигурация для второго задания(http)](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/task2_http_haproxy.cfg)

Результат выполнения

![haproxy_http_example_local](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/haproxy_http_example_local.png)

</i>

---

### Задание 3*

<details>
  <summary>Текст задания</summary>

 - Настройте связку HAProxy + Nginx как было показано на лекции.
 - Настройте Nginx так, чтобы файлы .jpg выдавались самим Nginx (предварительно разместите несколько тестовых картинок в директории /var/www/), а остальные запросы переадресовывались на HAProxy, который в свою очередь переадресовывал их на два Simple Python server.
 - На проверку направьте конфигурационные файлы nginx, HAProxy, скриншоты с запросами jpg картинок и других файлов на Simple Python Server, демонстрирующие корректную настройку.
  </details>

<i>

[Настройка /etc/haproxy/haproxy.cfg](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/haproxy_task3.cfg)

[Настройка /etc/nginx/nginx.conf](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/nginx.conf)

[Настройка /etc/nginx/sites-available/default](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/default)

![localhost2](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/localhost2.png)

![localhost](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/localhost.png)

![redirection](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/2/img/redirection.png)

</i>

### Задание 4*

<details>
  <summary>Текст задания</summary>

 - Запустите 4 simple python сервера на разных портах.
 - Первые два сервера будут выдавать страницу index.html вашего сайта example1.local (в файле index.html напишите example1.local)
 - Вторые два сервера будут выдавать страницу index.html вашего сайта example2.local (в файле index.html напишите example2.local)
 - Настройте два бэкенда HAProxy
 - Настройте фронтенд HAProxy так, чтобы в зависимости от запрашиваемого сайта example1.local или example2.local запросы перенаправлялись на разные бэкенды HAProxy
 - На проверку направьте конфигурационный файл HAProxy, скриншоты, демонстрирующие запросы к разным фронтендам и ответам от разных бэкендов.

 </details>

<i>



</i>

### Правила приема работы

1. Необходимо следовать инструкции по выполнению домашнего задания, используя для оформления репозиторий Github
2. В ответе необходимо прикладывать требуемые материалы - скриншоты, конфигурационные файлы, скрипты. Необходимые материалы для получения зачета указаны в каждом задании.


------

### Критерии оценки

 - Зачет - выполнены все задания, ответы даны в развернутой форме, приложены требуемые скриншоты, конфигурационные файлы, скрипты. В выполненных заданиях нет противоречий и нарушения логики
 - На доработку - задание выполнено частично или не выполнено, в логике выполнения заданий есть противоречия, существенные недостатки, приложены не все требуемые материалы.