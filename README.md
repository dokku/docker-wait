`wait` is a really small Docker utility that blocks until another container is accepting TCP connections.

The default operation looks for a single exported port. Use it like this:

    $ docker run -d --name mycontainer some-image-or-other
    $ docker run --link mycontainer:mycontainer n3llyb0y/wait
    waiting for TCP connection to 172.17.0.105:5432......ok

note: it doesn't matter what the link alias is.

If the container you are linking to has multiple port exports then you will need
to let `wait` know which ones you are interested in. To do so, set the PORTS environment
variable at run:

    $ docker run -d --name mycontainer some-image-or-other
    $ docker run -e PORTS=80,443 --link mycontainer:mycontainer n3llyb0y/wait
    waiting for TCP connection to 172.17.0.105:80......ok
    waiting for TCP connection to 172.17.0.105:443......ok

`wait` will also interrogate linked services that share the same port (as within a cluster, for example)

    $ docker run -d -p 9200 --name cluster1 some-image-or-other
    $ docker run -d -p 9200 --name cluster2 some-image-or-other
    $ docker run -e PORTS=9200 --link cluster1:w1 --link cluster2:w2 n3llyb0y/wait
    waiting for TCP connection to 172.17.0.105:9200......ok
    waiting for TCP connection to 172.17.0.106:9200......ok

By default each connection attempt will bail after 30 seconds. You can specify an override using the TIMEOUT env variable:

    $ docker run -d -p 9200 -p 32000 --name myservice some-image-or-other
    $ docker run -e PORTS="9200 32000" -e TIMEOUT=10 --link myservice:w1 n3llyb0y/wait
    waiting for TCP connection to 172.17.0.105:9200...ok
    waiting for TCP connection to 172.17.0.105:32000............WARN: unable to connect

credits

The single port usage idea and dockerfile was pulled from aanand/wait: https://github.com/aanand/docker-wait
