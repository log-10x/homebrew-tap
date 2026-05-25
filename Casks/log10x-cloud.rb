# Copyright 2025-2026 Log10x, Inc.
# SPDX-License-Identifier: Apache-2.0

cask "log10x-cloud" do
  version "1.1.1"

  on_arm do
    sha256 "662dc3c109c48aaafb4c3664995b5935a0216ef89459441b9f5c36c6e7965bf1"
    url "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-cloud-#{version}.dmg",
        verified: "github.com/log-10x/pipeline-releases/"
  end

  on_intel do
    sha256 "22f5a5f5b9a539310b1112c3f6fc4962ef92b787142af09ac89b81a798e7f483"
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
