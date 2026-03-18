# Copyright 2025-2026 Log10x, Inc.
# SPDX-License-Identifier: Apache-2.0

cask "log10x-cloud" do
  version "1.0.4"

  on_arm do
    sha256 "e1e487d757836ec8aaedb086398811f500279faa6ef3c01c076cec6313705a0b"
    url "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-cloud-#{version}.dmg",
        verified: "github.com/log-10x/pipeline-releases/"
  end

  on_intel do
    sha256 "5df43f931e7b901fe4f5bd8d8c47c4681991323a101b3c61e6086cc8110790eb"
    url "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-cloud-#{version}-intel.dmg",
        verified: "github.com/log-10x/pipeline-releases/"
  end

  name "Log10x"
  desc "Observability runtime for log/trace data optimization"
  homepage "https://log10x.com/"

  livecheck do
    url "https://github.com/log-10x/pipeline-releases/releases/latest"
    strategy :github_latest
  end

  app "tenx-cloud.app"
  preflight do
    # Download and install configuration files
    version = cask.version.to_s
    base_url = "https://github.com/log-10x/pipeline-releases/releases/download/#{version}"
    config_dir = "#{HOMEBREW_PREFIX}/etc/tenx"

    FileUtils.mkdir_p "#{config_dir}/config"
    FileUtils.mkdir_p "#{config_dir}/symbols"

    system_command "/usr/bin/curl",
                   args: ["-fsSL", "#{base_url}/tenx-config-#{version}.tar.gz", "-o", "/tmp/tenx-config.tar.gz"],
                   sudo: false

    system_command "/usr/bin/tar",
                   args: ["-xzf", "/tmp/tenx-config.tar.gz", "-C", "#{config_dir}/config"],
                   sudo: false

    system_command "/usr/bin/curl",
                   args: ["-fsSL", "#{base_url}/tenx-symbols-#{version}.10x.tar", "-o", "#{config_dir}/symbols/tenx-symbols-#{version}.10x.tar"],
                   sudo: false
  end

  postflight do
    # Create wrapper script that sets defaults but respects user overrides
    config_dir = "#{HOMEBREW_PREFIX}/etc/tenx"
    bin = "#{HOMEBREW_PREFIX}/bin/tenx"
    File.write(bin, <<~EOS)
      #!/bin/bash
      export TENX_CONFIG="${TENX_CONFIG:-#{config_dir}/config}"
      export TENX_SYMBOLS_PATH="${TENX_SYMBOLS_PATH:-#{config_dir}/symbols}"
      exec /Applications/tenx-cloud.app/Contents/MacOS/tenx-cloud "$@"
    EOS
    FileUtils.chmod 0755, bin
  end

  uninstall delete: [
    "#{HOMEBREW_PREFIX}/etc/tenx",
    "#{HOMEBREW_PREFIX}/bin/tenx",
  ]

  zap trash: [
    "~/Library/Application Support/Log10x",
    "~/Library/Caches/Log10x",
    "~/Library/Preferences/com.log10x.*",
  ]

  caveats <<~EOS
    The `tenx` command is now on your PATH.

    Configuration defaults to #{HOMEBREW_PREFIX}/etc/tenx/.
    To override, set TENX_CONFIG and/or TENX_SYMBOLS_PATH in your environment.

    Log10x requires a commercial license for production use.
    Visit https://log10x.com/pricing for licensing options.
  EOS
end
