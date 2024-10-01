### Задание 1

2. Допустимо сохранить личную, секретную информацию в файле personal.auto.tfvars.

3. random_string: 3JVTM2dLJU9qpp24

4. Отсутвует имя у ресурса (resource "docker_image") и имя ресурса начинается с цифры (resource "docker_container" "1nginx" ). Неверно указано имя ресурса (name  = "example_${random_password.random_string_FAKE.resulT}").

5. 
```
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = true
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  name  = "example_${random_password.random_string.result}"

  ports {
    internal = 80
    external = 9090
  }
}
``` 
```
vlitvinov@laptop01:~/project/netology/ter-homeworks/01/src$ docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS         PORTS                  NAMES
9de500ea434b   9527c0f683c3   "/docker-entrypoint.…"   10 seconds ago   Up 9 seconds   0.0.0.0:9090->80/tcp   example_3JVTM2dLJU9qpp24
```

6. 
```
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
4ace63d3898f   9527c0f683c3   "/docker-entrypoint.…"   3 seconds ago   Up 2 seconds   0.0.0.0:9090->80/tcp   hello_world
```
Применение изменений Terraform без подтверждения не позволяет посмотреть, что именно будет изменено и можно случайно удалить инфраструктуру. Возможно, данный ключ можно использовать для CD для развёртывания инфраструктуры для dev и test окружений.

8.
```
{
  "version": 4,
  "terraform_version": "1.9.6",
  "serial": 11,
  "lineage": "3b641413-1db7-d817-d4d0-e6c69a28e314",
  "outputs": {},
  "resources": [],
  "check_results": null
}
```

9. Образ не был удалён, т.к. в main.tf было явно указано сохранение образа keep_locally = true.
```
keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation. 
```