class Luadata < Formula
  desc "Parse Lua data files and convert to JSON"
  homepage "https://github.com/mmobeus/luadata"
  version "0.1.17"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_arm64.tar.gz"
      sha256 "85d1c0bd884657728bdf20e2341ed90476a64dc2ada22bcc386ce3453f1d2874"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_amd64.tar.gz"
      sha256 "a44729e9ab8bf4b4a33c99e222d26091655180b6232f5b068e62a83a2ead778e"
    end
  end

  def install
    bin.install "luadata"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luadata --version")
  end
end
