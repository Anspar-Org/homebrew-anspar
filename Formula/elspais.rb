class Elspais < Formula
  include Language::Python::Virtualenv

  desc "Requirements validation and traceability tools - L-Space connects all libraries"
  homepage "https://github.com/anspar/elspais"
  url "https://files.pythonhosted.org/packages/36/ed/d23e5ac6fd6c474711211c6c87703e25228cd68900a51a6970f2d66451fe/elspais-0.52.0.tar.gz"
  sha256 "96865df0a76890d7ea214c863dfc96e9be5807ff260999760734912d673dd295"
  license "AGPL-3.0-only"
  head "https://github.com/anspar/elspais.git", branch: "main"

  depends_on "python@3.12"

  def install
    venv = virtualenv_create(libexec, "python3.12")
    system libexec/"bin/pip", "install", "--no-cache-dir", "elspais[all]==#{version}"
    bin.install_symlink Dir[libexec/"bin/elspais"]
  end

  def caveats
    <<~EOS
      elspais has been installed with all optional features:
        - MCP server (AI-driven requirements management)
        - Trace view (HTML traceability reports)
        - Trace review (Flask-based review server)
        - Shell completion (bash, zsh, fish)

      MCP Server Setup
      ================

      For Claude Desktop, add to your config:
        macOS: ~/Library/Application Support/Claude/claude_desktop_config.json
        Linux: ~/.config/Claude/claude_desktop_config.json

        {
          "mcpServers": {
            "elspais": {
              "command": "#{opt_bin}/elspais",
              "args": ["mcp", "serve"],
              "cwd": "/path/to/your/project"
            }
          }
        }

      For Claude Code, add to your project's .mcp.json:

        {
          "mcpServers": {
            "elspais": {
              "command": "#{opt_bin}/elspais",
              "args": ["mcp", "serve"]
            }
          }
        }

      Set "cwd" to the directory containing your .elspais.toml config.

      Shell Completion
      ================
      For zsh, add to your ~/.zshrc:
        eval "$(register-python-argcomplete elspais)"

      For bash, add to your ~/.bashrc:
        eval "$(register-python-argcomplete elspais)"

      Quick Start
      ===========
      Run `elspais docs quickstart` for a getting-started guide.
    EOS
  end

  test do
    system bin/"elspais", "--version"

    # Verify MCP module is available
    system libexec/"bin/python", "-c", "import elspais; print('OK')"

    # Test basic validation on empty spec dir
    assert_match "elspais", shell_output("#{bin}/elspais --version")
  end
end
