# Copyright 2025-2026 Log10x, Inc.
# SPDX-License-Identifier: Apache-2.0

class Log10x < Formula
  desc "Observability runtime for log/trace data optimization"
  homepage "https://log10x.com/"
  version "1.0.4"
  license :cannot_represent

  on_arm do
    url "https://github.com/log-10x/pipeline-releases/releases/download/1.0.4/tenx-edge-1.0.4-macos-arm64-native",
        verified: "github.com/log-10x/pipeline-releases/"
    sha256 "c5ed833e862614fd832fcdb8bee3eda79d6a34e41998888103d6fe2ff25c5a73"
  end

  on_intel do
    url "https://github.com/log-10x/pipeline-releases/releases/download/1.0.4/tenx-edge-1.0.4-macos-amd64-native",
        verified: "github.com/log-10x/pipeline-releases/"
    sha256 "b60e32401e859c434db43d48686979346dd0724933b383867b93dfb302ebbf4b"
  end

  livecheck do
    url "https://github.com/log-10x/pipeline-releases/releases/latest"
    strategy :github_latest
  end

  def install
    # The downloaded binary name varies by architecture
    binary = Dir["tenx-edge-*-native"].first || Dir["tenx*"].first
    bin.install binary => "tenx"

    # Create config directories
    (etc/"tenx/config").mkpath
    (etc/"tenx/symbols").mkpath

    # Download configuration files
    system "curl", "-fsSL",
      "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-config-#{version}.tar.gz",
      "-o", "#{buildpath}/tenx-config.tar.gz"
    system "tar", "-xzf", "#{buildpath}/tenx-config.tar.gz", "-C", etc/"tenx/config"

    # Download symbol library
    system "curl", "-fsSL",
      "https://github.com/log-10x/pipeline-releases/releases/download/#{version}/tenx-symbols-#{version}.10x.tar",
      "-o", etc/"tenx/symbols/tenx-symbols-#{version}.10x.tar"
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
