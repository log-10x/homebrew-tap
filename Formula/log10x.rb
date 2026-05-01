# Copyright 2025-2026 Log10x, Inc.
# SPDX-License-Identifier: Apache-2.0

class Log10x < Formula
  desc "Observability runtime for log/trace data optimization"
  homepage "https://log10x.com/"
  version "1.0.15"
  license :cannot_represent

  on_arm do
    url "https://github.com/log-10x/pipeline-releases/releases/download/1.0.15/tenx-edge-1.0.15-macos-arm64-native",
        verified: "github.com/log-10x/pipeline-releases/"
    sha256 "f9f37f7d9c52f100a6e15bf13f4b4ee1046671b9c49a14000ca6a63d05c25113"
  end

  on_intel do
    url "https://github.com/log-10x/pipeline-releases/releases/download/1.0.15/tenx-edge-1.0.15-macos-amd64-native",
        verified: "github.com/log-10x/pipeline-releases/"
    sha256 "67996be09bcc0f9794a6dd3af9db10c5425ff5040ee72c2c5084779a05bc5656"
  end

  livecheck do
    url "https://github.com/log-10x/pipeline-releases/releases/latest"
    strategy :github_latest
  end

  def install
    # Install the native binary
    binary = Dir["tenx-edge-*-native"].first || Dir["tenx*"].first
    libexec.install binary => "tenx-edge"
    chmod 0755, libexec/"tenx-edge"

    # Create directories
    (etc/"tenx/config").mkpath
    (etc/"tenx/symbols").mkpath
    (lib/"tenx/modules").mkpath

    # Download and install modules (pipeline spec files required by native binary)
    system "curl", "-fsSL",
      "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-modules-#{version}.tar.gz",
      "-o", "#{buildpath}/tenx-modules.tar.gz"
    system "tar", "-xzf", "#{buildpath}/tenx-modules.tar.gz", "-C", lib/"tenx/modules"

    # Download configuration files
    system "curl", "-fsSL",
      "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-config-#{version}.tar.gz",
      "-o", "#{buildpath}/tenx-config.tar.gz"
    system "tar", "-xzf", "#{buildpath}/tenx-config.tar.gz", "-C", etc/"tenx/config"

    # Download symbol library
    system "curl", "-fsSL",
      "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-symbols-#{version}.10x.tar",
      "-o", etc/"tenx/symbols/tenx-symbols-#{version}.10x.tar"

    # Create wrapper script that sets default paths
    (bin/"tenx").write <<~EOS
      #!/bin/bash
      export TENX_CONFIG="${TENX_CONFIG:-#{etc}/tenx/config}"
      export TENX_SYMBOLS_PATH="${TENX_SYMBOLS_PATH:-#{etc}/tenx/symbols}"
      export TENX_MODULES="${TENX_MODULES:-#{lib}/tenx/modules}"
      exec "#{libexec}/tenx-edge" "$@"
    EOS
  end

  def caveats
    <<~EOS
      The `tenx` command is now on your PATH.

      Configuration defaults to #{etc}/tenx/.
      To override, set TENX_CONFIG and/or TENX_SYMBOLS_PATH in your environment.

      Log10x requires a commercial license for production use.
      Visit https://log10x.com/pricing for licensing options.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tenx --version 2>&1", 1)
  end
end
