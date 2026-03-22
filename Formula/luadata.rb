class Luadata < Formula
  desc "Parse Lua data files and convert to JSON"
  homepage "https://github.com/mmobeus/luadata"
  version "0.1.16"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_arm64.tar.gz"
      sha256 "69555b88666841edae1dff93da63d19a073c5b750e80c476daa485a344096272"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_amd64.tar.gz"
      sha256 "7c158634c33ac5456f76a8180778547fb1a06f8499cfd0229ac7129bf3e22196"
    end
  end

  def install
    bin.install "luadata"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luadata --version")
  end
end
