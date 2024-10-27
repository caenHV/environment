# How to choose a needed utility script&

## Nothing is installed

First of all, you need to check that docker is installed:

```bash
docker -v
```

This command will output something like:

```shell
Docker version 26.1.4, build 5650f9b
```

If docker is not installed, you need to do it asap. The official Docker site is [here](https://docs.docker.com/).

If Docker is installed, you need to run the following script **install_soft.sh**. Please note that root rights are necessary.

```bash
sudo ./install_soft.sh
```

If everything is okay, this script will start all docker containers. Otherwise, you should contact one of the maintainers.

## No connection to devback

Most probably the A3818 board drivers stopped working properly after some accident.
In this case you need **reinstall_drivers.sh**. Please note that root rights are necessary.

```bash
sudo ./reinstall_drivers.sh
```
