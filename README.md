# Log10x Homebrew Tap

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Homebrew formulae and casks for [Log10x](https://doc.log10x.com).

## Install

```sh
# Edge flavor: native CLI binary
brew install log-10x/tap/log10x

# Cloud flavor: full macOS app with bundled JRE (required for symbol compilation)
brew install --cask log-10x/tap/log10x-cloud
```

Both install the `tenx` command on your PATH.

## Packages

| Name | Type | Flavor | Contents |
|------|------|--------|----------|
| `log10x` | Formula | [Edge](https://doc.log10x.com/engine/flavors/#edge) | `tenx-edge` native binary, pipeline modules, configuration, symbol libraries |
| `log10x-cloud` | Cask | [Cloud](https://doc.log10x.com/engine/flavors/#cloud) | `tenx-cloud.app` (bundled JRE), configuration, symbol libraries |

Pick **`log10x`** to run edge apps (Dev, Reporter, Receiver). Pick **`log10x-cloud`** to also run the Compiler and cloud apps.

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

This repository is licensed under the [Apache License 2.0](LICENSE).

### Important: Log10x Product License Required

This repository contains Homebrew formulae and casks for installing Log10x. While the
formulae and casks themselves are open source, **using Log10x requires a commercial license**.

| Component | License |
|-----------|---------|
| This repository (Homebrew formulae and casks) | Apache 2.0 (open source) |
| Log10x engine and runtime | Commercial license required |

**What this means:**

- You can freely use, modify, and distribute these Homebrew formulae and casks
- The Log10x software that these install requires a paid subscription
- A valid Log10x license is required to run the installed software

**Get Started:**

- [Log10x Pricing](https://log10x.com/pricing)
- [Documentation](https://doc.log10x.com)
- [Contact Sales](mailto:sales@log10x.com)
