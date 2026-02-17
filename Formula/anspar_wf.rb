class AnsparWf < Formula
  include Language::Python::Virtualenv

  desc "Development toolchain for requirement-traceable software projects"
  homepage "https://github.com/Anspar-Org/anspar-wf"
  url "https://files.pythonhosted.org/packages/70/39/deba53a0c52b6378fdbcc7ac82cb7b8d55e0c1d2287ae43ac226fb42b25f/anspar_wf-0.2.1.tar.gz"
  sha256 "01e3c4930fa608a71f3148cd208a6ee1907fdde4dd5b515251fa61298dbca432"
  license "MIT"
  head "https://github.com/Anspar-Org/anspar-wf.git", branch: "main"

  depends_on "python@3.12"

  resource "anyio" do
    url "https://files.pythonhosted.org/packages/96/f0/5eb65b2bb0d09ac6776f2eb54adee6abe8228ea05b20a5ad0e4945de8aac/anyio-4.12.1.tar.gz"
    sha256 "41cfcc3a4c85d3f05c932da7c26d0201ac36f72abd4435ba90d0464a3ffed703"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/e0/2d/a891ca51311197f6ad14a7ef42e2399f36cf2f9bd44752b3dc4eab60fdc5/certifi-2026.1.4.tar.gz"
    sha256 "ac726dd470482006e014ad384921ed6438c457018f4b3d204aea4281258b2120"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/3d/fa/656b739db8587d7b5dfa22e22ed02566950fbfbcdc20311993483657a5c0/click-8.3.1.tar.gz"
    sha256 "12ff4785d337a1bb490bb7e9c2b1ee5da3112e94a8622f26a6c77f5d2fc6842a"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/01/ee/02a2c011bdab74c6fb3c75474d40b3052059d95df7e73351460c8588d963/h11-0.16.0.tar.gz"
    sha256 "4e35b956cf45792e4caa5885e69fba00bdbc6ffafbfa020300e549b208ee5ff1"
  end

  resource "httpcore" do
    url "https://files.pythonhosted.org/packages/06/94/82699a10bca87a5556c9c59b5963f2d039dbd239f25bc2a63907a05a14cb/httpcore-1.0.9.tar.gz"
    sha256 "6e34463af53fd2ab5d807f399a9b45ea31c3dfa2276f15a2c3f00afff6e176e8"
  end

  resource "httpx" do
    url "https://files.pythonhosted.org/packages/b1/df/48c586a5fe32a0f01324ee087459e112ebb7224f646c0b5023f5e79e9956/httpx-0.28.1.tar.gz"
    sha256 "75e98c5f16b0f35b567856f597f06ff2270a374470a5c2392242528e3e3e42fc"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/6f/6d/0703ccc57f3a7233505399edb88de3cbd678da106337b9fcde432b65ed60/idna-3.11.tar.gz"
    sha256 "795dafcc9c04ed0c1fb032c2aa73654d8e8c5023a7df64a53f39190ada629902"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/65/ee/299d360cdc32edc7d2cf530f3accf79c4fca01e96ffc950d8a52213bd8e4/packaging-26.0.tar.gz"
    sha256 "00243ae351a257117b6a241061796684b084ed1c516a08c48a3f7e147a9d80b4"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/72/94/1a15dd82efb362ac84269196e94cf00f187f7ed21c242792a923cdb1c61f/typing_extensions-4.15.0.tar.gz"
    sha256 "0cea48d173cc12fa28ecabc3b837ea3cf6f38c6d1136f85cbaaf598984861466"
  end

  def install
    virtualenv_install_with_resources
  end

  def caveats
    <<~EOS
      anspar-wf has been installed.

      CLI Usage
      =========
        anspar-wf install       # Install dev tools (gitleaks, squawk, elspais, markdownlint)
        anspar-wf check         # Verify tool versions
        anspar-wf validate      # Validate requirements
        anspar-wf trace         # Generate traceability views

      MCP Server Setup (Claude Code)
      ===============================
      Add to your project's .mcp.json:

        {
          "mcpServers": {
            "traceability": {
              "command": "#{opt_bin}/anspar-wf",
              "args": ["mcp", "traceability"]
            },
            "compliance": {
              "command": "#{opt_bin}/anspar-wf",
              "args": ["mcp", "compliance"]
            }
          }
        }

      Claude Code Plugins (Optional)
      ===============================
      To register the plugin marketplace in a project:

        anspar-wf plugins register --project-dir /path/to/project
    EOS
  end

  test do
    system bin/"anspar-wf", "--version"
    system libexec/"bin/python", "-c", "import anspar_wf; print('OK')"
  end
end
