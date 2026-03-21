class Luadata < Formula
  desc "Parse Lua data files and convert to JSON"
  homepage "https://github.com/mmobeus/luadata"
  version "0.1.11"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_arm64.tar.gz"
      sha256 "e24120ca8962d5ed9cb41096e5f319e64917abe92871f624f5bdd901c7915b9a"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_amd64.tar.gz"
      sha256 "a2b2e7c1664db53043ea7dc0f8cbec2b6380919cd00e4bb05cc3ba1dc62e3985"
    end
  end

  def install
    bin.install "luadata"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luadata --version")
  end
end
