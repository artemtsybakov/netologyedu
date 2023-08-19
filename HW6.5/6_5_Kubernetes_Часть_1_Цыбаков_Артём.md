## Задание 1

> Выполните действия:
>
> 1. Запустите Kubernetes локально, используя k3s или minikube на свой выбор.
> 2. Добейтесь стабильной работы всех системных контейнеров.
> 3. В качестве ответа пришлите скриншот результата выполнения команды kubectl get po -n kube-system.


### Устанавливаем k3s 

```curl -sfL https://get.k3s.io > install_k3s```

Команда загружает содержимое сценария в файл install_k3s

Изучаем сценарий на предмет вредоносного кода.

![Текст сценария в Vim](/images/6-5-1-1.png)

Устанвливаем приложение командой

```sh install_k3s```

Скриншот результата выполнения команды ``` kubectl get po -n kube-system```

![Результат установки](/images/6-5-1.png)

## Задание 2

> Выполните действия:
>
>1. Измените файл с учётом условий:
>- redis должен запускаться без пароля;
>- создайте Service, который будет направлять трафик на этот Deployment;
>- версия образа redis должна быть зафиксирована на 6.0.13.
>- Запустите Deployment в своём кластере и добейтесь его стабильной работы.
>В качестве решения пришлите получившийся файл.

Файл deployment-redis.yaml

```---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: redis
spec:
  selector:
    matchLabels:
      app: redis
  replicas: 1
  template:
    metadata:
      labels:
        app: redis
    spec:
      containers:
      - name: master
        image: bitnami/redis
        env:
         - name: REDIS_PASSWORD
           value: password123
        ports:
        - containerPort: 6379
```
### Создание объекта обслуживания 

service-redis.yaml

```
apiVersion: v1
kind: Service
metadata:
  name: redis
  labels:
    run: redis
spec:
  ports:
  - port: 80
    protocol: TCP
  selector:
    run: redis
```

### Изменение объекта развертывания

Добавил версию к образу redis.

Убрал переменную с логином и паролем.

```spec:
      containers:
      - name: master
        image: bitnami/redis:6.0.13
        ports:
        - containerPort: 6379
```
Запускаем развертывание

```sudo kubectl apply -f HW6.5/deployment-redis.yaml```

Проверка развертывания 

```sudo kubectl get deployment```

Не работает

![Проверка развертывания](/images/6-5-1-2.png)

Проверка пода

```sudo kubectl get pod```

Не запустился и выдает ошибку

![Проверка пода](/images/6-5-1-3.png)

Просмотр журнала пода 

```sudo kubectl logs redis-86bcc69464-q```

В журнале ошибка

![Проверка пода](/images/6-5-1-4.png)

Под не может запустится потому что не указана переменная с паролем. Что бы разрешить доступ без пароля нужно указать переменную ALLOW_EMPTY_PASSWORD=yes.

Удаляем старую развертку и изменяем файл разветки. Добавляем переменную.

```sudo kubectl delete deployment redis```


```		env:
         - name: ALLOW_EMPTY_PASSWORD
           value: "yes"
```

Запуск развертывания. Провека. Все работает.

![Результат перезапуска развертки](/images/6-5-1-5.png)
![Результат перезапуска пода](/images/6-5-1-6.png)


## Задание 3





