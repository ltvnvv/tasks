### Задание 1. Создать Deployment и обеспечить доступ к контейнерам приложения по разным портам из другого Pod внутри кластера

1. Создать Deployment приложения, состоящего из двух контейнеров (nginx и multitool), с количеством реплик 3 шт.

[deployment.yaml](manifests/04/deployment.yaml)

```sh
kubectl create -f deployment.yaml
```

2. Создать Service, который обеспечит доступ внутри кластера до контейнеров приложения из п.1 по порту 9001 — nginx 80, по 9002 — multitool 8080.

[svc.yaml](manifests/04/svc.yaml)

```sh
kubectl create -f svc.yaml
```

3. Создать отдельный Pod с приложением multitool и убедиться с помощью `curl`, что из пода есть доступ до приложения из п.1 по разным портам в разные контейнеры.

[pod.yaml](manifests/04/pod.yaml)

```sh
kubectl create -f pod.yaml 
kubectl exec -it multitool-test -- curl http://10.152.183.148:9001
kubectl exec -it multitool-test -- curl http://10.152.183.148:9002
```

![screenshot](img/1.png)

4. Продемонстрировать доступ с помощью `curl` по доменному имени сервиса.
5. Предоставить манифесты Deployment и Service в решении, а также скриншоты или вывод команды п.4.

![screenshot](img/2.png)

------

### Задание 2. Создать Service и обеспечить доступ к приложениям снаружи кластера

1. Создать отдельный Service приложения из Задания 1 с возможностью доступа снаружи кластера к nginx, используя тип NodePort.

[svc.yaml](manifests/04/svc-nodeport.yaml)

```sh
kubectl create -f svc-nodeport.yaml
```

2. Продемонстрировать доступ с помощью браузера или `curl` с локального компьютера.
3. Предоставить манифест и Service в решении, а также скриншоты или вывод команды п.2.

![screenshot](img/3.png)

------
