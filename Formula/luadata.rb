class Luadata < Formula
  desc "Parse Lua data files and convert to JSON"
  homepage "https://github.com/mmobeus/luadata"
  version "0.1.14"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_arm64.tar.gz"
      sha256 "ca87096520c4ba08f42d005038d43adcd5b46d130d70d2122742a187b2efab03"
    elsif Hardware::CPU.intel?
      url "https://github.com/mmobeus/luadata/releases/download/v#{version}/luadata-darwin_amd64.tar.gz"
      sha256 "8fc698bd9157fe4695baf2175fa63d23b2d13ec0480262e55d249fa9566f633a"
    end
  end

  def install
    bin.install "luadata"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/luadata --version")
  end
end
