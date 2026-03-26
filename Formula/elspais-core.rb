class ElspaisCore < Formula
  include Language::Python::Virtualenv

  desc "Requirements validation and traceability tools (core only)"
  homepage "https://github.com/anspar/elspais"
  url "https://files.pythonhosted.org/packages/cf/f1/020ef6644ba47d06e3ff7e811a4ae44dfe0b9a696f34b7fdcef28799cde6/elspais-0.112.13.tar.gz"
  sha256 "b16e5ed6f17d94af6ab8a96f8ccff59b1cef2f043e2798d53e702332ce978cdd"
  license "AGPL-3.0-only"

  bottle do
    root_url "https://github.com/Anspar-Org/homebrew-anspar/releases/download/elspais-0.104.44"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "857add387e5606ec865a3ed05088dc71fb1322d132d82234f26f00cbb68facb7"
  end

  depends_on "python@3.12"

  conflicts_with "elspais", because: "both install the `elspais` binary"

  resource "tomlkit" do
    url "https://files.pythonhosted.org/packages/b5/11/87d6d29fb5d237229d67973a6c9e06e048f01cf4994dee194ab0ea841814/tomlkit-0.14.0-py3-none-any.whl"
    sha256 "592064ed85b40fa213469f81ac584f67a4f2992509a7c3ea2d632208623a3680"
  end

  def install
    python3 = "python3.12"
    venv = virtualenv_create(libexec, python3)

    resources.each do |r|
      r.stage do
        system libexec/"bin/python", "-m", "pip", "install",
               *std_pip_args(prefix: libexec, build_isolation: true), "."
      end
    end

    system libexec/"bin/python", "-m", "pip", "install",
           *std_pip_args(prefix: libexec, build_isolation: true), "."
    bin.install_symlink Dir[libexec/"bin/elspais"]
  end

  def caveats
    <<~EOS
      This is the core-only install (minimal dependencies).
      For MCP server, HTML reports, and other features, use instead:
        brew install anspar-org/elspais/elspais
    EOS
  end

  test do
    system bin/"elspais", "--version"
  end
end
