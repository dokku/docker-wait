`wait` is a really small Docker utility that blocks until another container is accepting TCP connections, and errors-out if it cannot connect within a given timeout. I use this
in CI environments to ensure that server containers are up before tests begin running
against them.

The default operation looks up all the `EXPOSE`d ports of all the linked containers
and waits for them

```shell
$ docker run -d --name mycontainer some-image-or-other
$ docker run --link mycontainer:mycontainer waisbrot/wait
waiting for 172.17.0.105:5432  .  up!
Everything is up
```

It doesn't matter what the link alias is.

If you want to wait for only a subset of the links/ports, or you want to connect
to hosts/ports that haven't been linked by Docker, you can provide the list in
the `TARGETS` variable:

```shell
$ docker run -e TARGETS=8.8.8.8:53,github.com:443 waisbrot/wait
waiting for 8.8.8.8:53  .  up!
waiting for github.com:443  .  up!
Everything is up
```

By default each connection attempt will bail after 30 seconds. You can specify an override using the `TIMEOUT` env variable:

```shell
$ docker run -e TARGETS=github.com:5432 waisbrot/wait
waiting for github.com:5432  ...............................  ERROR: unable to connect
```

If any TARGET times out, the `wait` container immediately exits with status code 1

**credits**

The single port usage idea and dockerfile was pulled from aanand/wait: https://github.com/aanand/docker-wait
