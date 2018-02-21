### Steps

- Build the image using `docker build -t quay.io/quintype/sbt-alpine:1.1.1 .`
- Push the image to Quay using `docker push quay.io/quintype/sbt-alpine:1.1.1`.

You might need to setup docker to allow login to Quay - https://docs.quay.io/guides/login.html

When a new version of `sbt` is released, say `1.1.2`, then update Dockerfile with the same. And use the appropriate tag when building and pushing the image.
