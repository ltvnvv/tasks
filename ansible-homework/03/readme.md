# Ansible Playbook для установки Clickhouse, Lightshot и Vector

Этот Ansible playbook предназначен для автоматической установки и настройки систем баз данных Clickhouse, графического интерфейса для ClickHouse и Vector на виртуальных машинах.

## Описание

Playbook выполняет следующие задачи:

1. Play `Install Clickhouse` устанавливает и настраивает Clickhouse:
   - Загружает необходимые RPM-пакеты.
   - Устанавливает Clickhouse.
   - Создаёт базу данных "logs".
   - Запускает Clickhouse сервис.

2. Play `Install Vector`  устанавливает и настраивает Vector:
   - Загружает и распаковывает дистрибутив Vector.
   - Устанавливает исполняемый файл Vector.
   - Настраивает конфигурационную директорию и файл.
   
3. Play `Install nginx`  устанавливает и настраивает веб-сервер nginx на хост с Lighthouse:
   - Загружает необходимые RPM-пакеты.
   - Устанавливает Nginx.
   - Настраивает конфигурационную директорию и файл.
   - Настраивает директорию для логов.

4. Play `Install Lighthouse`  устанавливает и настраивает GUI Lighthouse:
   - Загружает необходимые RPM-пакеты.
   - Скачивает git-репозиторий.

## Параметры
Параметры определяются с помощью переменных в директории `/playbook/group_vars/`
- `clickhouse_version`: Версия Clickhouse, которая будет установлена. (например, `21.9.3.30`).
- `clickhouse_packages`: Список пакетов Clickhouse, которые нужно загрузить и установить.
- `lighthouse_vcs`: URL git-репозитория.
- `lighthouse_location`: - директория lighthouse
- `vector_version`: Версия Vector, которая будет установлена. (например, `0.14.0`).
- `vector_config_dir`: Директория с файлом конфигурации vector

Конфигурационный файл vector.yaml формируется на основе шаблона `templates/vector.config.j2`
Служба Vector формируется на основе шаблона `templates/vector.service.j2`
Конфигурационный файл nginx.conf формируется на основе шаблона `templates/nginx.conf.j2`
Конфигурационный файл nginx.lighthouse.conf формируется на основе шаблона `templates/nginx.lighthouse.conf.j2`

## Теги

- `clickhouse`: Используется для выполнения задач, связанных с установкой и настройкой Clickhouse.
- `vector`: Используется для выполнения задач, связанных с установкой и настройкой Vector.

## Использование

1. Создать 3 VM в облаке
2. Указать Public IP в `inventory/prod.yml`
3. Запустите playbook с помощью команды:

```bash
ansible-playbook -i inventory/prod.yml site.yml
```