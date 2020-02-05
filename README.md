# docker-vpn-client
> Demo: Single-Application VPN using Docker

This project contains an example Docker implementation for running a
single application on an Ubuntu Linux system that accesses the Internet
through a VPN server.  *Only* the one application goes across the VPN;
the rest of the system is completely unaffected.

bittorrent is used as an example application here. I'm not very familiar
with it and further configuration may be required.

![](header.gif)

## File description

All of the files are pretty short and self-explanatory.

- Dockerfile - description telling docker how to build the container
- ./build.sh - command that runs 'docker build' to generate docker-vpn-client image
- ./run.sh - command that instantiates a container using the image
- ./start.sh - commands that container runs at startup
- ./client.ovpn - OpenVPN configuration file (not provided)

### Notes about client.ovpn

The user must copy their own OpenVPN configuration file to
./client.ovpn.  For obvious reasons, I'm not going to include mine.

I avoided baking client.ovpn into the docker image by passing it in when
the container is started. For that reason, extra arguments must be
provided to `docker run` or the container won't work. `run.sh` handles
that.

## Build image

The following command builds a Docker image called vpn-build.

```sh
./build.sh
```

## Run container

The following command starts a container using the vpn-build image.
Make sure ./client.ovpn exists before running (see above).

```sh
./run.sh
```

The OpenVPN client daemon is started in the container, as well as the
bittorrent `transmission-daemon`. Then it drops down to a shell where
the user can run additional commands like `transmission-cli`. When the
shell exits, the docker container will exit and be removed.

Note that any files created inside the docker container will be lost
when the container exits. In order that there is somewhere to write
files that will survive, `run.sh` also mounts the volume `/tmp/files/`
into the container from the same directory on the host machine.

## Release History

* 0.0.1
    * Work in progress

## Meta

Curt McDowell \<coder@fishlet.com\>

Distributed under the BSD license. See [LICENSE](./LICENSE) for more information.

[https://github.com/curtmcd/docker-vpn-client](https://github.com/curtmcd/docker-vpn-client)

## Contributing

1. Click Fork at https://github.com/curtmcd/docker-vpn-client
2. Create your feature branch locally (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request
