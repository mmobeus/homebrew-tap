class Yo < Formula
  desc "Start, find and tear down Claude Code sessions, each on its own git worktree"
  homepage "https://github.com/mmobeus/yo"
  version "0.2.0"
  license "MIT"

  depends_on "jq"

  # The arm64 sha256 comes first: update-formula.yml relies on the order.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/yo/releases/download/v#{version}/yo-darwin_arm64.tar.gz"
      sha256 "b46425cfdb9e7b28bee9be1fe097b7d115c06d7fc06b559b192f58171b479869"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/yo/releases/download/v#{version}/yo-darwin_amd64.tar.gz"
      sha256 "2cdee02a0635a6102bc30b4ed3b0b5d9cbef86e75d47a1fa8d45abc5ff2d3f7f"
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
