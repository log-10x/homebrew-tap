# Log10x Homebrew Tap

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Homebrew formulae and casks for [Log10x](https://www.log10x.com/?utm_source=github&utm_medium=readme&utm_campaign=homebrew-tap&utm_content=hero).

## Install

```sh
# runtime flavor: native CLI binary
brew install log-10x/tap/log10x

# compiler flavor: full macOS app with bundled JRE (required for symbol compilation)
brew install --cask log-10x/tap/log10x-cloud
```

Both install the `tenx` command on your PATH.

## Packages

| Name | Type | Flavor | Contents |
|------|------|--------|----------|
| `log10x` | Formula | runtime | `tenx-edge` native binary, pipeline modules, configuration, symbol libraries |
| `log10x-cloud` | Cask | compiler | `tenx-cloud.app` (bundled JRE), configuration, symbol libraries |

Pick **`log10x`** to run the Reporter, Receiver, Retriever, MCP server and CLI. Pick **`log10x-cloud`** to also run `generate`, compile and link.

The names on the left keep the old flavor words, and so do the `tenx-edge` /
`tenx-cloud` names on disk. Cask tokens, formula file names and release-asset
URLs are names rather than flag values: Homebrew ties a cask token to its file
name, and log-10x/engine's release job rewrites both files by exact path on
every release. See
[FLAVORS.md](https://github.com/log-10x/pipeline-releases/blob/main/FLAVORS.md)
for the full mapping and for what would have to change in lockstep to rename
them.

## Update

```sh
brew update
brew upgrade log10x          # formula
brew upgrade --cask log10x-cloud   # cask
```

## Uninstall

```sh
brew uninstall log10x
brew uninstall --cask log10x-cloud
```

## License

This repository is licensed under the [MIT License](LICENSE).

### Important: Log10x Product License Required

This repository contains Homebrew formulae and casks for installing Log10x. While the
formulae and casks themselves are open source, **using Log10x requires a commercial license**.

| Component | License |
|-----------|---------|
| This repository (Homebrew formulae and casks) | MIT (open source) |
| Log10x engine and runtime | Commercial license required |

**What this means:**

- You can freely use, modify, and distribute these Homebrew formulae and casks
- The Log10x software that these install requires a paid subscription
- A valid Log10x license is required to run the installed software

**Get Started:**

- [Log10x Pricing](https://www.log10x.com/pricing?utm_source=github&utm_medium=readme&utm_campaign=homebrew-tap&utm_content=footer)
- [Documentation](https://doc.log10x.com)
- [Contact Sales](mailto:sales@log10x.com)
