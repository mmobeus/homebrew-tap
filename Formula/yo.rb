class Yo < Formula
  desc "Start, find and tear down Claude Code sessions, each on its own git worktree"
  homepage "https://github.com/mmobeus/yo"
  version "0.2.1"
  license "MIT"

  depends_on "jq"

  # The arm64 sha256 comes first: update-formula.yml relies on the order.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/yo/releases/download/v#{version}/yo-darwin_arm64.tar.gz"
      sha256 "623308f3dadb77e2645f470f6800920f431ce878e3a8e1e81b03c1c23c507318"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/yo/releases/download/v#{version}/yo-darwin_amd64.tar.gz"
      sha256 "cea01e863f8465ceb45eb1af8489d88fc1900eb65eaee3ba823fa384865d18ef"
    end
  end

  def install
    bin.install "yo"
  end

  def caveats
    <<~EOS
      Run `yo setup` to install yo's Claude Code skills, settings layer and
      statusline (and, once, a starting config). Run it again after upgrading.
    EOS
  end

  test do
    assert_match "yo #{version}", shell_output("#{bin}/yo --version")
  end
end
