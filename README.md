### Steps for building the image

- Build the image using `docker build -t quay.io/quintype/sbt-alpine:1.1.1 .`
- Push the image to Quay using `docker push quay.io/quintype/sbt-alpine:1.1.1`.

You might need to setup docker to allow login to Quay - https://docs.quay.io/guides/login.html

When a new version of `sbt` is released, say `1.1.2`, then update Dockerfile with the same. And use the appropriate tag when building and pushing the image.

### Steps for using the image

```
docker run --rm -it quay.io/quintype/sbt-alpine:1.1.1 sbt
```

### sbt dependencies cache

This image already has the dependencies for sbt 1.1.1 already downloaded and cached. This way any container started from this image, won't waste time downloading the dependencies for sbt itself.

However, when using with projects that declare their own dependencies, those will be downloaded each time a new container is created from this image. One solution is to mount the host's `~/.ivy2` and `~/.sbt` directories onto the container. Depending on the state of the two directories, the first time the container is created, it might take a really long time to be usable.

```
mkdir -p ~/.ivy2 && mkdir -p ~/.sbt
docker run --rm -it \
           --mount type=bind,src="$HOME/.ivy2",dst=/root/.ivy2 \
           --mount type=bind,src="$HOME/.sbt",dst=/root/.sbt \
           quay.io/quintype/sbt-alpine:1.1.1 \
           sbt sbtVersion
```
