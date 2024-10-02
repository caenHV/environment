# Setting environment

## Разворачиваем среду на `dq11cmd`

1. Из-под пользователя `root` установить драйверы **A3818Drv-1.6.8** по инструкции из соответстующего Readme
1. Из-под пользователя `root` установить `docker` с помощью [официальной инструкции](https://docs.docker.com/engine/install/centos/)
1. Создать директорию для работы `/setups/caen`
1. Создать (если не создана) группу разработчиков `caen_devs` (из-под `root`) 
```bash
groupadd caen_devs
```
Добавить необходимых пользователей (например `petrov`) в эту группу
```bash
usermod -a -G caen_devs petrov
```
Больше информации в [статье](https://losst.pro/gruppy-polzovatelej-linux).

Дополнительные полезные ссылки:
* [Как установить дефолтную группу для пользователя, когда он создаёт файл](https://askubuntu.com/questions/51951/set-default-group-for-user-when-they-create-new-files)
* [Как установить дефолтные права на файлы в директории](https://unix.stackexchange.com/questions/1314/how-to-set-default-file-permissions-for-all-folders-files-in-a-directory)

5. (Опционально) разрешить sudo конкретному пользователю через [добавление](https://wiki.merionet.ru/articles/kak-dat-polzovatelyu-sudo-prava-v-centos-8/) его в группу wheel
