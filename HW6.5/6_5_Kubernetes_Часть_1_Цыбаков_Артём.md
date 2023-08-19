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

![Текст сценария в Vim](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-1.png)

Устанвливаем приложение командой

```sh install_k3s
```

Скриншот результата выполнения команды ``` kubectl get po -n kube-system```

![Результат установки](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1.png)

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

![Проверка развертывания](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-2.png)

Проверка пода

```sudo kubectl get pod```

Не запустился и выдает ошибку

![Проверка пода](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-3.png)

Просмотр журнала пода 

```sudo kubectl logs redis-86bcc69464-q```

В журнале ошибка

![Проверка пода](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-4.png)

Под не может запустится потому что не указана переменная с паролем. Что бы разрешить доступ без пароля нужно указать переменную ALLOW_EMPTY_PASSWORD=yes.

Удаляем старую развертку и изменяем файл разветки. Добавляем переменную.

```sudo kubectl delete deployment redis```


```		env:
         - name: ALLOW_EMPTY_PASSWORD
           value: "yes"
```		   

Запуск развертывания. Провека. Все работает.

![Результат развертывания](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-5.png)

![Результат перезапуска пода](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-6.png)


## Задание 3

>Выполните действия:
>
>1. Напишите команды kubectl для контейнера из предыдущего задания:
> - выполнения команды ps aux внутри контейнера;
> - просмотра логов контейнера за последние 5 минут;
> - удаления контейнера;
> - проброса порта локальной машины в контейнер для отладки.
>2. В качестве решения пришлите получившиеся команды.

```sudo kubectl exec redis-7bfccd74cd-j9nbj -- ps aux```

![ps aux](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-8.png)

```sudo kubectl logs redis-7bfccd74cd-j9nbj```

![log](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-7.png)

```sudo kubectl delete pod redis-7bfccd74cd-j9nbj```

Под был удален и создан с другим именем.

![delete](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-10.png)

```sudo kubectl port-forward redis-7bfccd74cd-j9nbj 6379:6379```

![port-forward](https://github.com/artemtsybakov/netologyedu/blob/d7d6adc3ca613d5924613ba8131f66e3ab91d551/HW6.5/images/6-5-1-9.png)


