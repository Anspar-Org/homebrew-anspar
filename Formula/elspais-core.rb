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

  def install
    virtualenv_create(libexec, "python3.12")
    # Install from PyPI (uses wheel, avoids sdist build chain issues)
    system libexec/"bin/pip", "install", "elspais==#{version}"
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
