class Yo < Formula
  desc "Start, find and tear down Claude Code sessions, each on its own git worktree"
  homepage "https://github.com/mmobeus/yo"
  version "0.1.1"
  license "MIT"

  depends_on "jq"

  # The arm64 sha256 comes first: update-formula.yml relies on the order.
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/yo/releases/download/v#{version}/yo-darwin_arm64.tar.gz"
      sha256 "be73d3227881e48a14e3d654ed651d0aeb95b3dcfcc54c2a491a73ac96cb1ae9"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/yo/releases/download/v#{version}/yo-darwin_amd64.tar.gz"
      sha256 "335524b32acbb67070d1361e6320375ec68a0b9c16c724953cf60b75f8cf4c52"
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
