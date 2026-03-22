class Luadata < Formula
  desc "Parse Lua data files and convert to JSON"
  homepage "https://github.com/mmobeus/luadata"
  version "0.1.18"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_arm64.tar.gz"
      sha256 "a4eac222ad3a1bea924b56b0581419232fa0c347289a829efcd022ae0316364a"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_amd64.tar.gz"
      sha256 "419fb1d13be0977c4d013c64a44953bc166e621a8ac8458cfb03d9a928286fbf"
    end
  end

  def install
    bin.install "luadata"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luadata --version")
  end
end
