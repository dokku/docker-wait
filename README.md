`wait` is a really small (9MB) Docker utility that blocks until another container is accepting TCP connections, and errors-out if it cannot connect within a given timeout. It can be used to ensure that a service is up and running before starting another service that depends on it.

The default operation looks up all the `EXPOSE`d ports of all the linked containers
and waits for them

```shell
$ docker run -d --name mycontainer some-image-or-other
$ docker run --link mycontainer:mycontainer --rm martin/wait
waiting for 172.17.0.105:5432  .  up!
Everything is up
```

It doesn't matter what the link alias is.

If you want to wait for only a subset of the links/ports, or you want to connect
to hosts/ports that haven't been linked by Docker, you can provide the list with
the `-c` parameter:

```shell
$ docker run --rm martin/wait -c 8.8.8.8:53,github.com:443
waiting for 8.8.8.8:53  .  up!
waiting for github.com:443  .  up!
Everything is up
```

By default each connection attempt will bail after 30 seconds. You can override this with `-t` parameter:

```shell
$ docker run martin/wait -c github.com:5432 -t 15
waiting for github.com:5432  ...............................  ERROR: unable to connect
```

If any connection times out, the `wait` container immediately exits with status code 1

**credits**

waisbrot/wait: https://github.com/waisbrot/docker-wait
n3llyb0y/wait: https://github.com/n3llyb0y/docker-wait
aanand/wait: https://github.com/aanand/docker-wait
