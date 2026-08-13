# Homebrew formula for the lingvo CLI.
#
# This file is a template. `.github/workflows/release-cli.yml` fills in 0.1.0 and d08db7cf0ff75da8126fb07f15c39b155261cd900c7ba2b46b1c149d9a223d98 on
# every tagged release and writes the result to the tap repository as Formula/lingvo.rb.
#
# The tap is a separate, public repository holding this one file and nothing else:
#
#   https://github.com/Merkost/homebrew-lingvo
#
# so that `brew install merkost/lingvo/lingvo` resolves without the product source being public.
# It hosts the release archives as well, for the same reason: a private repository's assets need a
# token to download, which is no use to `brew install` or to `curl | sh`.
#
# **`depends_on "openjdk@21"` is the reason this channel exists.** The install script can only tell
# somebody they need a JDK; brew installs one. Android developers already have a runtime and CI is
# one line of setup-java — the people without one are the iOS and web developers, who are mostly on
# macOS, which is exactly who this reaches.
class Lingvo < Formula
  desc "Localization without word limits"
  homepage "https://lingvo.dev"
  url "https://github.com/Merkost/homebrew-lingvo/releases/download/v0.1.0/lingvo-0.1.0.zip"
  version "0.1.0"
  sha256 "d08db7cf0ff75da8126fb07f15c39b155261cd900c7ba2b46b1c149d9a223d98"

  depends_on "openjdk@21"

  def install
    libexec.install Dir["*"]
    # Not a symlink into libexec: the Gradle start script resolves its own location to find the jars,
    # and it needs JAVA_HOME pinned to the JDK brew just installed rather than to whatever `java`
    # happens to be first on PATH — which on a developer's Mac is frequently an Android Studio JBR.
    (bin/"lingvo").write_env_script libexec/"bin/lingvo",
                                    JAVA_HOME: Formula["openjdk@21"].opt_prefix
  end

  test do
    # Deliberately more than "it exits 0": a wrapper that lost JAVA_HOME still exits 0 on some
    # machines and fails on the reviewer's.
    assert_match "lingvo version #{version}", shell_output("#{bin}/lingvo --version")
  end
end
