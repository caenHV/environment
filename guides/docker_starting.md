## Гайды docker
* Tutorial for installation
https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04-ru
* Подробный гайд https://badtry.net/docker-tutorial-dlia-novichkov-rassmatrivaiem-docker-tak-iesli-by-on-byl-ighrovoi-pristavkoi/
* Советы по составлению Dockerfile https://softwaremill.com/7-quick-steps-to-improve-your-dockerfile/


## Подсказки для docker
* `docker images` - список всех загруженных образов
* `docker ps` - список всех запущенных контейнеров
  * `-a` - список с учётом уже завершивших работу контейнеров
* `docker build <DOCKERFILE_DIRECTORY> --tag <image>` - собрать контейнер с названием `<image>` из директории `<DOCKERFILE_DIRECTORY>`.
* `docker run <image>` - запустить контейнер `<image>`
  * `-it` - в интерактивном режиме
  * `--rm` - удаляет запущенный контейнер после работы
  * `--privileged` - запуск в привилегированном режиме (открывает доступ к устройствам)
  * `-v <DIRECTORY>:<CONTAINER_DIRECTORY>` - монтирование папки из основной системы, `<DIRECTORY>` - это путь к папке, которую нужно смонтировать, `<CONTAINER_DIRECTORY>` - путь внутри контейнера
  * `-p <HOST_PORT>:<CONTAINER_PORT>` - открыть порт

### Дополнительные команды
* `docker image rm <image_name>` - удалить контейнер `<image_name>`

## Пример запуска docker-контейнера
```bash
docker run -it --rm --privileged -v ./controller:/controller test_img
```
запуск контейнера `test_img` в интерактивном (`-it`), привилегированном (`--privileged`) режимах с удалением после завершения работы (`--rm`), в который примонтирована директория из основной системы (`-v`).

## Troubleshooting

### Закончилось место на диске
проблема акутальна для `dq11cmd`, поскольку docker хранит свой кэш в папке `/var/lib/docker` (там немного свободного места)
* командой `df -h /var/` можно посмотреть количество свободного места в папке
* если всё плохо, то помогает команда [`docker system prune`](https://docs.docker.com/engine/reference/commandline/system_prune/) или можно поискать ещё решения [на форумах](https://forums.docker.com/t/docker-no-space-left-on-device/69205)

### Docker ругается при запуске на то, что порт уже выделен

Если при поптыке запустить образ Docker выдаёт что-то подбное 
```
docker: Error response from daemon: driver failed programming external connectivity on endpoint xenodochial_chandrasekhar (00c428b8fdbd8cc34c6eb6103a7ea1fc0ab4a0c2d97178d520c6081f428742b5): Bind for 0.0.0.0:8000 failed: port is already allocated.
```
То простым и действенным решением этой беды может быть перезапуск Docker-а:
```
$ sudo service docker stop
Redirecting to /bin/systemctl stop docker.service
Warning: Stopping docker.service, but it can still be activated by:
  docker.socket
$ sudo service docker start
Redirecting to /bin/systemctl start docker.service
```

Причём стоит заметить то, что другие Docker-комманды могут не работать из-за 
```
permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get "http://%2Fvar%2Frun%2Fdocker.sock/v1.24/containers/json": dial unix /var/run/docker.sock: connect: permission denied
```
Такая ошибка возникает, если предыдущая сессия с контейнером завершилась криво. Например, вы через ssh подключились к dq11cmd, запустили контейнер, но произошёл обрыв соединения между вашей машиной и dq11cmd. 
В таком случае возможно кривое завершение (не завершение) работы контейнера.
