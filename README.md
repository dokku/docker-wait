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

credits

The basic single port usage and dockerfile was pulled from aanand/wait: https://github.com/aanand/docker-wait
