# Домашнее задание к занятию 1 "`«Disaster recovery и Keepalived»`" - `Цыбаков Артём`

### Цели задания
 В результате выполнения этого задания вы научитесь:
 1. Настраивать отслеживание интерфейса для протокола HSRP;
 2. Настраивать сервис Keepalived для использования плавающего IP


### Чеклист готовности к домашнему заданию

 1. Установлена программа Cisco Packet Tracer
 2. Установлена операционная система Ubuntu на виртуальную машину и имеется доступ к терминалу
 3. Сделан клон этой виртуальной машины, они находятся в одной подсети и имеют разные IP адреса
 4. Просмотрены конфигурационные файлы, рассматриваемые на лекции, которые находятся по [ссылке](1/)


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

 - Дана [схема](1/hsrp_advanced.pkt) для Cisco Packet Tracer, рассматриваемая в лекции.
 - На данной схеме уже настроено отслеживание интерфейсов маршрутизаторов Gi0/1 (для нулевой группы)
 - Необходимо аналогично настроить отслеживание состояния интерфейсов Gi0/0 (для первой группы).
 - Для проверки корректности настройки, разорвите один из кабелей между одним из маршрутизаторов и Switch0 и запустите ping между PC0 и Server0.
 - На проверку отправьте получившуюся схему в формате pkt и скриншот, где виден процесс настройки маршрутизатора. 
 </details>

<i>

Вывод информации на Router0 по протоколу HSRP команда `sh standby`

```
Router0#sh standby 
GigabitEthernet0/0 - Group 0 (version 2)
  State is Active
    7 state changes, last state change 00:00:19
  Virtual IP address is 192.168.0.1
  Active virtual MAC address is 0000.0C9F.F000
    Local virtual MAC address is 0000.0C9F.F000 (v2 default)
  Hello time 3 sec, hold time 10 sec
    Next hello sent in 2.204 secs
  Preemption enabled
  Active router is local
  Standby router is 192.168.0.3
  Priority 105 (configured 105)
    Track interface GigabitEthernet0/1 state Up decrement 10
  Group name is hsrp-Gig0/0-0 (default)
GigabitEthernet0/1 - Group 1 (version 2)
  State is Standby
    9 state changes, last state change 00:00:38
  Virtual IP address is 192.168.1.1
  Active virtual MAC address is 0000.0C9F.F001
    Local virtual MAC address is 0000.0C9F.F001 (v2 default)
  Hello time 3 sec, hold time 10 sec
    Next hello sent in 1.561 secs
  Preemption disabled
  Active router is 192.168.1.3
  Standby router is local
  Priority 50 (configured 50)
  Group name is hsrp-Gig0/1-1 (default)
Router0#
```
На Router0 нужно производим настройку. Для этого перейдем в настройки интерфейса. gigabitEthernet 0/1.

`interface gigabitEthernet 0/1`

Включить режим preempt

`standby 1 preempt`

Изменим приоритет маршрутизатора

`standby 1 priority 95`

и настроить отслеживание интерфейса gigabitEthernet 0/0 на случай разрыва связи

`standby 1 track gigabitEthernet 0/0`

Вывод информации по протоколу HSRP команда `sh standby` после настройки
```
GigabitEthernet0/0 - Group 0 (version 2)
  State is Active
    7 state changes, last state change 00:00:19
  Virtual IP address is 192.168.0.1
  Active virtual MAC address is 0000.0C9F.F000
    Local virtual MAC address is 0000.0C9F.F000 (v2 default)
  Hello time 3 sec, hold time 10 sec
    Next hello sent in 1.339 secs
  Preemption enabled
  Active router is local
  Standby router is 192.168.0.3
  Priority 105 (configured 105)
    Track interface GigabitEthernet0/1 state Up decrement 10
  Group name is hsrp-Gig0/0-0 (default)
GigabitEthernet0/1 - Group 1 (version 2)
  State is Standby
    9 state changes, last state change 00:00:38
  Virtual IP address is 192.168.1.1
  Active virtual MAC address is 0000.0C9F.F001
    Local virtual MAC address is 0000.0C9F.F001 (v2 default)
  Hello time 3 sec, hold time 10 sec
    Next hello sent in 1.11 secs
  Preemption enabled
  Active router is 192.168.1.3
  Standby router is local
  Priority 95 (configured 95)
    Track interface GigabitEthernet0/0 state Up decrement 10
  Group name is hsrp-Gig0/1-1 (default) 
```
Вывод информации на Router1 по протоколу HSRP команда `sh standby`

```
Router1#sh standby 
GigabitEthernet0/0 - Group 0 (version 2)
  State is Standby
    9 state changes, last state change 00:00:39
  Virtual IP address is 192.168.0.1
  Active virtual MAC address is 0000.0C9F.F000
    Local virtual MAC address is 0000.0C9F.F000 (v2 default)
  Hello time 3 sec, hold time 10 sec
    Next hello sent in 1.671 secs
  Preemption enabled
  Active router is 192.168.0.2
  Standby router is local
  Priority 100 (default 100)
    Track interface GigabitEthernet0/1 state Up decrement 10
  Group name is hsrp-Gig0/0-0 (default)
GigabitEthernet0/1 - Group 1 (version 2)
  State is Active
    7 state changes, last state change 00:00:27
  Virtual IP address is 192.168.1.1
  Active virtual MAC address is 0000.0C9F.F001
    Local virtual MAC address is 0000.0C9F.F001 (v2 default)
  Hello time 3 sec, hold time 10 sec
    Next hello sent in 1.263 secs
  Preemption enabled
  Active router is local
  Standby router is 192.168.1.2
  Priority 100 (default 100)
  Group name is hsrp-Gig0/1-1 (default)
```
На Router1 нужно производим настройку. Для этого перейдем в настройки интерфейса. gigabitEthernet 0/1.

`interface gigabitEthernet 0/1`

Настроить отслеживание интерфейса gigabitEthernet 0/0 на случай разрыва связи

`standby 1 track gigabitEthernet 0/0`

### Проверка 

Отключаем кабель от Router0. 

```
%LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/0, changed state to down
```

Состояние на Router1 изменилось 

```
%HSRP-6-STATECHANGE: GigabitEthernet0/0 Grp 0 state Standby -> Active
```

Пинг проходит

![Ping1](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/1/img/Ping1.jpg)

Подключаем кабель назад к Router0.
```
%LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/0, changed state to up

%HSRP-6-STATECHANGE: GigabitEthernet0/0 Grp 0 state Speak -> Standby

%HSRP-6-STATECHANGE: GigabitEthernet0/0 Grp 0 state Standby -> Active

%HSRP-6-STATECHANGE: GigabitEthernet0/1 Grp 1 state Speak -> Standby
```
Отключаем кабель от Router1.

```
%LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/0, changed state to down

%HSRP-6-STATECHANGE: GigabitEthernet0/1 Grp 1 state Speak -> Standby
```
Пинг проходит

![Ping2](https://github.com/artemtsybakov/netologyedu/blob/master/Fault_Tolerance/1/img/Ping2.jpg)

Покдлючаем кабель назад к Router1

```
%LINEPROTO-5-UPDOWN: Line protocol on Interface GigabitEthernet0/0, changed state to up

 %HSRP-6-STATECHANGE: GigabitEthernet0/1 Grp 1 state Standby -> Active

%HSRP-6-STATECHANGE: GigabitEthernet0/0 Grp 0 state Speak -> Standby

%HSRP-6-STATECHANGE: GigabitEthernet0/0 Grp 0 state Standby -> Active

%HSRP-6-STATECHANGE: GigabitEthernet0/0 Grp 0 state Speak -> Standby
```

</i>

---

### Задание 2

<details>
  <summary>Текст задания</summary>

 - Запустите две виртуальные машины Linux, установите и настройте сервис Keepalived как в лекции, используя пример конфигурационного [файла](1/keepalived-simple.conf).
 - Настройте любой веб-сервер (например, nginx или simple python server) на двух виртуальных машинах
 - Напишите Bash-скрипт, который будет проверять доступность порта данного веб-сервера и существование файла index.html в root-директории данного веб-сервера.
 - Настройте Keepalived так, чтобы он запускал данный скрипт каждые 3 секунды и переносил виртуальный IP на другой сервер, если bash-скрипт завершался с кодом, отличным от нуля (то есть порт веб-сервера был недоступен или отсутствовал index.html). Используйте для этого секцию vrrp_script
 - На проверку отправьте получившейся bash-скрипт и конфигурационный файл keepalived, а также скриншот с демонстрацией переезда плавающего ip на другой сервер в случае недоступности порта или файла index.html
 </details>

<i>

`sudo mv /var/www/html/index.nginx-debian.html /media/sf_share/`

![]()

```
student@Debian-keepalived-nginx-1:~$ sudo systemctl status keepalived.service 
● keepalived.service - Keepalive Daemon (LVS and VRRP)
     Loaded: loaded (/lib/systemd/system/keepalived.service; enabled; preset: enabled)
     Active: active (running) since Mon 2023-10-30 16:22:42 MSK; 12min ago
       Docs: man:keepalived(8)
             man:keepalived.conf(5)
             man:genhash(1)
             https://keepalived.org
   Main PID: 5313 (keepalived)
      Tasks: 2 (limit: 2293)
     Memory: 2.3M
        CPU: 8.319s
     CGroup: /system.slice/keepalived.service
             ├─5313 /usr/sbin/keepalived --dont-fork
             └─5314 /usr/sbin/keepalived --dont-fork

Oct 30 16:28:39 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: Script `nginx_check` now returning 0
Oct 30 16:28:39 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: VRRP_Script(nginx_check) succeeded
Oct 30 16:28:39 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) Entering BACKUP STATE
Oct 30 16:28:39 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) received lower priority (254) advert from 192>
Oct 30 16:28:40 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) received lower priority (254) advert from 192>
Oct 30 16:28:41 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) received lower priority (254) advert from 192>
Oct 30 16:28:42 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) Entering MASTER STATE
Oct 30 16:33:45 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: Script `file_check` now returning 1
Oct 30 16:33:45 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: VRRP_Script(file_check) failed (exited with status 1)
Oct 30 16:33:45 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) Entering FAULT STATE
```

`sudo mv /media/sf_share/index.nginx-debian.html /var/www/html/`

```
student@Debian-keepalived-nginx-1:~$ sudo systemctl status keepalived.service 
● keepalived.service - Keepalive Daemon (LVS and VRRP)
     Loaded: loaded (/lib/systemd/system/keepalived.service; enabled; preset: enabled)
     Active: active (running) since Mon 2023-10-30 16:22:42 MSK; 14min ago
       Docs: man:keepalived(8)
             man:keepalived.conf(5)
             man:genhash(1)
             https://keepalived.org
   Main PID: 5313 (keepalived)
      Tasks: 2 (limit: 2293)
     Memory: 2.3M
        CPU: 9.822s
     CGroup: /system.slice/keepalived.service
             ├─5313 /usr/sbin/keepalived --dont-fork
             └─5314 /usr/sbin/keepalived --dont-fork

Oct 30 16:33:45 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: Script `file_check` now returning 1
Oct 30 16:33:45 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: VRRP_Script(file_check) failed (exited with status 1)
Oct 30 16:33:45 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) Entering FAULT STATE
Oct 30 16:36:33 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: Script `file_check` now returning 0
Oct 30 16:36:33 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: VRRP_Script(file_check) succeeded
Oct 30 16:36:33 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) Entering BACKUP STATE
Oct 30 16:36:33 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) received lower priority (254) advert from 192>
Oct 30 16:36:34 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) received lower priority (254) advert from 192>
Oct 30 16:36:35 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) received lower priority (254) advert from 192>
Oct 30 16:36:36 Debian-keepalived-nginx-1 Keepalived_vrrp[5314]: (VI_1) Entering MASTER STATE

```
![]()
После переноса файла с виртуальной машины и обратного копирования на виртуальную машину, изменились права на доступ к файлу. Восстановим права командой `sudo chmod -u=755 /var/www/html/index.nginx-debian.html`.

После изменения прав все снова работает.
</i>

---

### Задание 3*

<details>
  <summary>Текст задания</summary>

 - Изучите дополнительно возможность Keepalived, которая называется vrrp_track_file
 - Напишите bash-скрипт, который будет менять приоритет внутри файла в зависимости от нагрузки на виртуальную машину (можно разместить данный скрипт в cron и запускать каждую минуту). Рассчитывать приоритет можно, например, на основании Load average.
 - Настройте Keepalived на отслеживание данного файла.
 - Нагрузите одну из виртуальных машин, которая находится в состоянии MASTER и имеет активный виртуальный IP и проверьте, чтобы через некоторое время она перешла в состояние SLAVE из-за высокой нагрузки и виртуальный IP переехал на другой, менее нагруженный сервер.
 - Попробуйте выполнить настройку keepalived на третьем сервере и скорректировать при необходимости формулу так, чтобы плавающий ip адрес всегда был прикреплен к серверу, имеющему наименьшую нагрузку.
 - На проверку отправьте получившийся bash-скрипт и конфигурационный файл keepalived, а также скриншоты логов keepalived с серверов при разных нагрузках
  </details>

<i>



</i>