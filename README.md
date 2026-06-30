# curlix Homebrew tap

Install the Curlix CLI (auth-first client for `login`, `connect`, etc.):

```sh
brew tap curlix-io/tap
brew install curlix
curlix login
```

## Layout

- `Formula/curlix.rb` — downloads prebuilt binaries from [curlix-io/curlix](https://github.com/curlix-io/curlix) GitHub Releases (`cli-v*` tags).

The canonical formula template lives in the main repo at `packaging/homebrew/curlix.rb`. The **Release CLI** workflow updates this file on each CLI release when `HOMEBREW_TAP_TOKEN` is configured on `curlix-io/curlix`.

Until a `cli-v*` release exists with real checksums, `brew install curlix` will fail — `brew tap` alone is enough to verify the tap is wired correctly.
