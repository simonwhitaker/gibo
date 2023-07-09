# To release a new version

1. Install [GoReleaser](https://goreleaser.com/):

    ```sh
    brew install goreleaser/tap/goreleaser
    ```

2. Create a new release tag:

    ```sh
    git tag -am 'vX.X.X' vX.X.X
    git push --tags
    ```

3. Run GoReleaser:

    GoReleaser requires `GITHUB_TOKEN` to be set. If you have the `gh` tool installed you can probably re-use the token it uses, by calling `gh auth token`:

    ```sh
    GITHUB_TOKEN=$(gh auth token) goreleaser release --clean
    ```

## To update Homebrew

TODO
