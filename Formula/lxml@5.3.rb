class LxmlAT53 < Formula
  include Language::Python::Virtualenv

  desc "Pythonic XML and HTML processing library"
  homepage "https://lxml.de/"
  url "https://lxml.de/files/lxml-5.3.0.tgz"
  sha256 "4e109ca30d1edec1ac60cdbe341905dc3b8f55b16855e03a54aaf59e51ec8c6f"
  license "BSD-3-Clause"
  revision 1

  depends_on "libxml2"
  depends_on "libxslt"
  depends_on "python@3.11" # or the Python version you are using

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    venv.pip_install buildpath/"."
  end

  test do
    (testpath/"test.py").write <<~EOS
      from lxml import etree

      def test_lxml():
          root = etree.Element("root")
          root.append(etree.Element("child"))
          print(etree.tostring(root))

      test_lxml()
    EOS

    ENV.prepend_path "PYTHONPATH", Formula["python@3.11"].opt_libexec/"lib/python3.11/site-packages"
    system Formula["python@3.11"].opt_bin/"python3", "test.py"
  end
end
