# Домашнее задание к занятию «`ELK`» - `Цыбаков Артём`

### Задание 1. Elasticsearch 

Установите и запустите Elasticsearch, после чего поменяйте параметр cluster_name на случайный. 

*Приведите скриншот команды 'curl -X GET 'localhost:9200/_cluster/health?pretty', сделанной на сервере с установленным Elasticsearch. Где будет виден нестандартный cluster_name*.

Установил docker. Загрузил образ elasticsearch с сайта Docker Hub. Запустил образ командой.
`sudo docker run --name elasticsearch --net somenetwork -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e "cluster.name=Tsybakov Artem" -e "xpack.security.enabled=false" elasticsearch:8.11.1`
В команде передал 3 переменные среды.
1. discovery.type=single-node
2. cluster.name=Tsybakov Artem имя кластера которое требуется для задания. Так же эту переменную можно указать в файле elasticsearch.yml. 
3. xpack.security.enabled=false

![]()

---

### Задание 2. Kibana

Установите и запустите Kibana.

*Приведите скриншот интерфейса Kibana на странице http://<ip вашего сервера>:5601/app/dev_tools#/console, где будет выполнен запрос GET /_cluster/health?pretty*.

Загрузил образ kibana с сайта Docker Hub. Запустил образ командой.
`sudo docker run --name kibana --net somenetwork -p 5601:5601 kibana:8.11.1`

![]()
---

### Задание 3. Logstash

Установите и запустите Logstash и Nginx. С помощью Logstash отправьте access-лог Nginx в Elasticsearch. 

*Приведите скриншот интерфейса Kibana, на котором видны логи Nginx.*


sudo docker run --rm -it -v ~/pipeline/:/usr/share/logstash/pipeline/ logstash:8.11.1

![]()
---

### Задание 4. Filebeat. 

Установите и запустите Filebeat. Переключите поставку логов Nginx с Logstash на Filebeat. 

*Приведите скриншот интерфейса Kibana, на котором видны логи Nginx, которые были отправлены через Filebeat.*


## Дополнительные задания (со звёздочкой*)
Эти задания дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже шире разобраться в материале.

### Задание 5*. Доставка данных 

Настройте поставку лога в Elasticsearch через Logstash и Filebeat любого другого сервиса , но не Nginx. 
Для этого лог должен писаться на файловую систему, Logstash должен корректно его распарсить и разложить на поля. 

*Приведите скриншот интерфейса Kibana, на котором будет виден этот лог и напишите лог какого приложения отправляется.*
![]()
