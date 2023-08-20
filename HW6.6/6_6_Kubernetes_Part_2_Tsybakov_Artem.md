### Задание 1
>Выполните действия:
> 1.Создайте свой кластер с помощью kubeadm.\
> 2.Установите любой понравившийся CNI плагин.\
> 3.Добейтесь стабильной работы кластера.
В качестве ответа пришлите скриншот результата выполнения команды ```kubectl get po -n kube-system```

### Выполнение

### Задание 2
>Есть файл с деплоем:
>```
>apiVersion: apps/v1
>kind: Deployment
>metadata:
>  name: redis
>spec:
>  selector:
>    matchLabels:
>     app: redis
>  replicas: 1
>  template:
>    metadata:
>      labels:
>        app: redis
>    spec:
>      containers:
>      - name: master
>        image: bitnami/redis
>        env:
>         - name: REDIS_PASSWORD
>           value: password123
>        ports:
>        - containerPort: 6379
>```
>Выполните действия:
>1.Создайте Helm Charts.
>2.Добавьте в него сервис.
>3.Вынесите все нужные, на ваш взгляд, параметры в ```values.yaml```.
>4.Запустите чарт в своём кластере и добейтесь его стабильной работы.
В качестве ответа пришлите вывод команды ```helm get manifest <имя_релиза>```