  # Qr

This is a repository for building Ruby environment with Docker. It also contains CircleCI configuration files.

## Installation

First of all, let's build a Ruby environment using Docker. If you have not installed Docker, please install it from [here](https://docs.docker.com/docker-for-mac/install/).

```shell
$ ./qr build
```

Make sure that Ruby is properly installed.

```shell
$ ./qr ruby -v
ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
```

Now, the development environment is built. Have a great Ruby life!
