1. 
```
ansible-playbook -i inventory/test.yml site.yml
```
![screenshot](img/1.png)

2. 
![screenshot](img/2.png)

3. 
```
docker run -d --name centos7 centos:7 sleep infinity
docker run -d --name ubuntu ubuntu:latest sleep infinity
```
4. 
```
ansible-playbook -i inventory/prod.yml site.yml
```
![screenshot](img/3.png)

6.  
![screenshot](img/4.png)

7. 
```
ansible-vault encrypt group_vars/el/examp.yml
ansible-vault encrypt group_vars/deb/examp.yml
```
![screenshot](img/5.png)

8. 
```
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![screenshot](img/6.png)

11. 
```
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```
![screenshot](img/7.png)
