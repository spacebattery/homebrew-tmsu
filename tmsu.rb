require "language/go"

class Tmsu < Formula
  desc "TMSU lets you tags your files and then access them through a nifty virtual filesystem from any other application."
  homepage "http://tmsu.org/"
  head "https://github.com/oniony/TMSU.git"

  depends_on "go" => :build
  depends_on "godep" => :build

  go_resource "github.com/mattn/go-sqlite3" do
    url "https://github.com/mattn/go-sqlite3.git"
  end

  go_resource "github.com/hanwen/go-fuse" do
    url "https://github.com/hanwen/go-fuse.git"
  end

  def install
    ENV["GOPATH"] = buildpath

    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "get", "-u", "golang.org/x/crypto/blake2b"

    system "go", "build", "-o", "bin/tmsu", "github.com/oniony/TMSU"
    bin.install "bin/tmsu"
    man1.install "misc/man/tmsu.1"
  end
end
