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
