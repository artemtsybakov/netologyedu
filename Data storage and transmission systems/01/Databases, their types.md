# Домашнее задание к занятию «`Базы данных, их типы`» - `Цыбаков Артём`

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

### Задание 1. СУБД

### Кейс
Крупная строительная компания, которая также занимается проектированием и девелопментом, решила создать правильную архитектуру для работы с данными. Ниже представлены задачи, которые необходимо решить для каждой предметной области.

Какие типы СУБД, на ваш взгляд, лучше всего подойдут для решения этих задач и почему?
 
1.1. Бюджетирование проектов с дальнейшим формированием финансовых аналитических отчётов и прогнозирования рисков. СУБД должна гарантировать целостность и чёткую структуру данных.
```
Для решения этой задачи лучше подойдет реляционная БД. Потому что она обеспечивает согласованность и доступность данных.
```
1.1.* Хеширование стало занимать длительно время, какое API можно использовать для ускорения работы? 

1.2. Под каждый девелоперский проект создаётся отдельный лендинг, и все данные по лидам стекаются в CRM к маркетологам и менеджерам по продажам. Какой тип СУБД лучше использовать для лендингов и для CRM? СУБД должны быть гибкими и быстрыми.

```
Для решения этой задачи лучше подойдет документная база данных, потому что под каждый лендинг можно сделать свой документ с разной структурой. Документы будут разными, но все это однотипные данные по лидам.
```
1.2.* Можно ли эту задачу закрыть одной СУБД? И если да, то какой именно СУБД и какой реализацией?

1.3. Отдел контроля качества решил создать базу по корпоративным нормам и правилам, обучающему материалу и так далее, сформированную согласно структуре компании. СУБД должна иметь простую и понятную структуру.
```
Для решения этой задачи лучше подойдет иерархическая база данных. Каждому элементу структуры компании будет соотвецтвовать свои нормы, правила и так далее.
```

1.3.* Можно ли под эту задачу использовать уже существующую СУБД из задач выше и если да, то как лучше это реализовать?

1.4. Департамент логистики нуждается в решении задач по быстрому формированию маршрутов доставки материалов по объектам и распределению курьеров по маршрутам с доставкой документов. СУБД должна уметь быстро работать со связями.
```
Для решения этой задачи лучше графовая база данных. При формировании маршрутов будут учитивыться расстояния между точками доставки.
```

1.4.* Можно ли к этой СУБД подключить отдел закупок или для них лучше сформировать свою СУБД в связке с СУБД логистов?
```
Для отдела закупок лучше использовать свою СУБД, потому для них данные о доставке не так важны. Информация по маршрутам интрересна отделу продаж а не отделу закупок.
```

1.5.* Можно ли все перечисленные выше задачи решить, используя одну СУБД? Если да, то какую именно?
```
Все перечисленные задачи можно решить используя реляционную СУБД. Эти задачи будут решаться немного медленее.
```

*Приведите ответ в свободной форме.*

---

### Задание 2. Транзакции

2.1. Пользователь пополняет баланс счёта телефона, распишите пошагово, какие действия должны произойти для того, чтобы транзакция завершилась успешно. Ориентируйтесь на шесть действий.
```
1. Узнать баланс на счету с которого будет списана сумма платаже.
2. Уменьшить баланс на сумму списания.
3. Сохранить новый баланс счета списания.
4. Узнать баланс на счету зачисления.
5. Увеличить баланс на счету зачисления на сумму платежа.
6. Сохранить баланс счета зачисления.
```

2.1.* Какие действия должны произойти, если пополнение счёта телефона происходило бы через автоплатёж?
```
Для пополнения телефона через автоплатёж требуются точно такие же действия.
```
*Приведите ответ в свободной форме.*

---

### Задание 3. SQL vs NoSQL

3.1. Напишите пять преимуществ SQL-систем по отношению к NoSQL. 
```
1. Хорошо подходят к хранению структурированных данных.
2. Лучшая поддержка транзакций ACID свойствами.
3. Мощьный язык запросов.
4. Готовые механизмы резевного копирования и восстановления.
5. Хорошая поддержка ПО.
```
3.1.* Какие, на ваш взгляд, преимущества у NewSQL систем перед SQL и NoSQL.
```
Использование ACID транзакций это преимущество NewSQL систем перед NoSQL системами.
Хорошее масштабирование это преимущество NewSQL систем перед SQL системами.
```
*Приведите ответ в свободной форме.*

---

### Задание 4. Кластеры

Необходимо производить большое количество вычислений при работе с огромным количеством данных, под эту задачу выделено 1000 машин. 

На основе какого критерия будете выбирать тип СУБД и какая модель *распределённых вычислений* 
здесь справится лучше всего и почему?

*Приведите ответ в свободной форме.*
```
Критерием для выбора типа и модели СУБД является одновременная работа 1000 машин с БД. БД должна обслуживать большое количество подключений и добавление большого количества типовых данных. Для этой задачи лучше использовать клиент-серверную модель вычислений и кластерную СУБД.
```

---

Задания,помеченные звёздочкой, — дополнительные, то есть не обязательные к выполнению, и никак не повлияют на получение вами зачёта по этому домашнему заданию. Вы можете их выполнить, если хотите глубже разобраться в материале.