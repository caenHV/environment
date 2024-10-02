## Создаю группу `caen_devs` и добавляю в неё пользователей
Появилась мысль создать пользовательскую группу, чтобы разрешить совместное редактирование файлов для всех пользователей внутри группы.
(Пока получилось неидеально)

1. Создал директорию для совместной работы `/setups/caen`
1. Создал (т.к. не создана) группу разработчиков `caen_devs` (из-под `root`) 
```bash
groupadd caen_devs
```
Добавил себя в эту группу (из-под `root`)
```bash
usermod -a -G caen_devs petrov
```
Больше информации в [статье](https://losst.pro/gruppy-polzovatelej-linux).

Поменял дефолтные настройки рабочей директории `/setups/caen`
* [Как установить дефолтную группу для пользователя, когда он создаёт файл](https://askubuntu.com/questions/51951/set-default-group-for-user-when-they-create-new-files)
* [Как установить дефолтные права на файлы в директории](https://unix.stackexchange.com/questions/1314/how-to-set-default-file-permissions-for-all-folders-files-in-a-directory)


Однако есть проблемы, например docker запускается только из-под `root`, поэтому либо всё равно придётся время от времени заходить из-под `root`, либо (опционально) разрешить команду `sudo` конкретному пользователю через [добавление](https://wiki.merionet.ru/articles/kak-dat-polzovatelyu-sudo-prava-v-centos-8/) его в группу wheel 
(замечу, что в итоге при применении sudo пароль надо будет использовать свой (как при подключении по ssh), а не root-пользователя)
