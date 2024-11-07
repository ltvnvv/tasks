Созданы 2 репозитория для vector-role и lighthouse-role:
Ссылки на репозитории:
https://github.com/ltvnvv/vector-role
https://github.com/ltvnvv/lighthouse-role

Создан файл `requirements.yml` и скачана Ansible-role:
```bash
ansible-galaxy install -r requirements.yml -p roles
```

Созданы 2 роли в новых репозиториях

Добавлены эти роли в `requirements.yml` и скачали их:
```bash
ansible-galaxy install -r requirements.yml -p roles
```

Изменили `site.yml` и запустил playbook:
```bash
ansible-playbook -i inventory/prod.yml site.yml
