# To release a new version

Update the version number, currently found in [gibo](./gibo) and [com.github.simonwhitaker.Gibo.appdata.xml](misc/com.github.simonwhitaker.Gibo.appdata.xml). Then:

```sh
export GIBO_VERSION=0.0.1 # replace with the updated version number
git tag -a -m $GIBO_VERSION $GIBO_VERSION
git push --tags
```

A new [Docker build](https://hub.docker.com/repository/docker/simonwhitaker/gibo/builds) will be triggered automatically.

## To update Homebrew

```sh
export GIBO_VERSION=0.0.1 # replace with the updated version number
export GIBO_URL=https://github.com/simonwhitaker/gibo/archive/${GIBO_VERSION}.tar.gz
export GIBO_SHA=$(curl -sSL $GIBO_URL | shasum -a 256 | cut -d' ' -f1)
brew bump-formula-pr gibo --url $GIBO_URL --sha256 $GIBO_SHA
```
