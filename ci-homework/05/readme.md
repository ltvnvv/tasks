# Домашнее задание к занятию 11 «Teamcity»

## Подготовка к выполнению

1. В Yandex Cloud создайте новый инстанс (4CPU4RAM) на основе образа `jetbrains/teamcity-server`.
2. Дождитесь запуска teamcity, выполните первоначальную настройку.
3. Создайте ещё один инстанс (2CPU4RAM) на основе образа `jetbrains/teamcity-agent`. Пропишите к нему переменную окружения `SERVER_URL: "http://<teamcity_url>:8111"`.
4. Авторизуйте агент.
![screenshot](img/2.png)
5. Сделайте fork [репозитория](https://github.com/aragastmatb/example-teamcity).
6. Создайте VM (2CPU4RAM) и запустите [playbook](./infrastructure).
Создал VM с Centos7. Отредактировал hosts.yaml и запустил playbook
```bash
ansible-playbook -i inventory/cicd/hosts.yml site.yml
```
![screenshot](img/1.png)

## Основная часть

1. Создайте новый проект в teamcity на основе fork.
https://github.com/ltvnvv/example-teamcity
![screenshot](img/3.png)

2. Сделайте autodetect конфигурации.
![screenshot](img/4.png)

3. Сохраните необходимые шаги, запустите первую сборку master.
![screenshot](img/5.png)

4. Поменяйте условия сборки: если сборка по ветке `master`, то должен происходит `mvn clean deploy`, иначе `mvn clean test`.
![screenshot](img/6.png)

5. Для deploy будет необходимо загрузить [settings.xml](./teamcity/settings.xml) в набор конфигураций maven у teamcity, предварительно записав туда креды для подключения к nexus.
![screenshot](img/7.png)

6. В pom.xml необходимо поменять ссылки на репозиторий и nexus.
7. Запустите сборку по master, убедитесь, что всё прошло успешно и артефакт появился в nexus.
![screenshot](img/8.png)

8. Мигрируйте `build configuration` в репозиторий.
![screenshot](img/9.png)

9. Создайте отдельную ветку `feature/add_reply` в репозитории.
```
git branch -C feature/add_reply
```
10. Напишите новый метод для класса Welcomer: метод должен возвращать произвольную реплику, содержащую слово `hunter`.
11. Дополните тест для нового метода на поиск слова `hunter` в новой реплике.
12. Сделайте push всех изменений в новую ветку репозитория.
13. Убедитесь, что сборка самостоятельно запустилась, тесты прошли успешно.
![screenshot](img/10.png)

14. Внесите изменения из произвольной ветки `feature/add_reply` в `master` через `Merge`.
15. Убедитесь, что нет собранного артефакта в сборке по ветке `master`.
После мержа ветки `feature/add_reply` в `master` автоматически запустилась сборка. Артефакта в Nexus не появилось.
16. Настройте конфигурацию так, чтобы она собирала `.jar` в артефакты сборки.
17. Проведите повторную сборку мастера, убедитесь, что сбора прошла успешно и артефакты собраны.
18. Проверьте, что конфигурация в репозитории содержит все настройки конфигурации из teamcity.
19. В ответе пришлите ссылку на репозиторий.
В pom.xml указал версию 0.0.3. Сборка запустилась автоматически и опубликовала артефакты в nexus.
![screenshot](img/11.png)
