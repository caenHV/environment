# Environment guide

## `dq11cmd`
* На `dq11cmd` у нас будет находиться `DeviceBackend`, `Monitor` (и даже `WebService` пока что)

### Идея 
запустим все сервисы в docker-контейнере.

У нас есть питоновские пакеты `caen_setup` (модуль для работы с CAEN) и `caen_tools` (набор микросервисов).
Соответственно в продакшене в контейнере поставим необходимые пакеты и запустим соответствующие скрипты.

### Реализация
- [x] Создать рабочую директорию, выставить права доступа
  * Используется директория `/setups/caen`
  * Все драйверы лежат в `/setups/caen/soft` (A3818Drv-1.6.8, CAENComm-v1.6.0, CAENHVWrapper-6.3, CAENVMELib-v3.4.0)
  * Небольшой гайд, как это всё делалось [по ссылке](guides/group_policies.md)
- [x] Установить драйверы 
  * [**A3818Drv-1.6.8**](https://www.caen.it/download/?filter=A3818)  на `dq11cmd` по инструкции из соответстующего Readme
  * Установку остальных прописать в docker-образе в следующем порядке: [**CAENVMELib-v3.4.0**](https://www.caen.it/download/?filter=CAENVMELib%20Library), [**CAENComm-v1.6.0**](https://www.caen.it/products/caencomm-library/), [**CAENHVWrapper-6.3**](https://www.caen.it/products/caen-hv-wrapper-library/)
- [x] Установить `docker`
  * Сделал согласно [официальной инструкции](https://docs.docker.com/engine/install/centos/) из директории `/setups/caen`

- [x] Развернуть docker образ
  * Развернул образ с названием `caen_device_docker` согласно [Dockerfile](dq11/Dockerfile) (по команде `docker build -t caen_device_docker .`)
  * Образ можно запустить по команде `docker run -it --rm caen_device_docker` (`-it`: интерактивный режим, `--rm`: удалить после закрытия)
  * Если необходима работа с устройством, то запустить в `--privileged` режиме, если необходимо смонитровать директорию, то добавить `-v` (более подробно в гайде)
  * Краткий гайд по докеру [по ссылке](guides/docker_starting.md)
  * Места на основном диске немного, поэтому перенёс кэш в более свободное место (см. [подробности](https://github.com/caenHV/environment/issues/2))

- [x] Поставить необходимые модули в контейнер
  * В dev режиме можно примонтировать папки с репозиториями к контейнеру, чтобы не делать docker build заново при изменениях в репосах (в [гайде](guides/docker_starting.md) есть немного о монтировании).
  * [Как работать](guides/private_github.md) с приватными репозиториями github

## `dq1cmd`
* На `dq1cmd` будет находиться `WebService`

## Полезные инструкции

* [Запускаем управление CAEN'ом в в dev режиме](./guides/dev_launch.md)