# Log10x Homebrew Tap

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Homebrew formulae and casks for [Log10x](https://doc.log10x.com) products.

Log10x is an **observability runtime** - it is to log/trace data what Chrome V8 is to JavaScript:
an engine for dynamically optimizing execution to reduce the cost of data processing.

## Installation

```sh
brew tap log-10x/tap
```

## Available Packages

| Package | Type | Description | Status |
|---------|------|-------------|--------|
| `log10x` | Cask | Log10x Cloud with bundled JRE | Coming in v1.0 |

## Usage

Once the tap is added, install packages with:

```sh
# Install the Log10x cask (GUI/bundled app)
brew install --cask log10x

# Or install a specific formula (CLI)
brew install log10x
```

## Updating

```sh
brew update
brew upgrade log10x
```

## License

This repository is licensed under the [Apache License 2.0](LICENSE).

### Important: Log10x Product License Required

This repository contains Homebrew formulae for installing Log10x. While the
formulae themselves are open source, **using Log10x requires a commercial license**.

| Component | License |
|-----------|---------|
| This repository (Homebrew formulae) | Apache 2.0 (open source) |
| Log10x engine and runtime | Commercial license required |

**What this means:**
- You can freely use, modify, and distribute these Homebrew formulae
- The Log10x software that these formulae install requires a paid subscription
- A valid Log10x license is required to run the installed software

**Get Started:**
- [Log10x Pricing](https://log10x.com/pricing)
- [Documentation](https://doc.log10x.com)
- [Contact Sales](mailto:sales@log10x.com)
