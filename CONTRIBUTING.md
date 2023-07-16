# To release a new version automatically

Just pust a version tag (e.g. `v3.0.1-beta.1`) to Github

## To release a new version manually

1. Install [GoReleaser](https://goreleaser.com/):

    ```sh
    brew install goreleaser/tap/goreleaser
    ```

2. Create a new release tag:

    ```sh
    git tag -am 'vX.X.X' vX.X.X
    git push --tags
    ```

NB! Tags of the form `vX.X.X-alpha.X` will fail to upload to Chocolatey with a 504 GatewayTimeout error. The final dot is the problem; use `vX.X.X-alphaX` instead.

3. Run GoReleaser:

    GoReleaser requires `GITHUB_TOKEN` to be set. If you have the `gh` tool installed you can probably re-use the token it uses, by calling `gh auth token`:

    ```sh
    GITHUB_TOKEN=$(gh auth token) goreleaser release --clean
    ```
