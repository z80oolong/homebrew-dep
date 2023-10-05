class LxmlAT49 < Formula
  include Language::Python::Virtualenv

  desc "Pythonic XML and HTML processing library"
  homepage "https://lxml.de/"
  url "https://lxml.de/files/lxml-4.9.2.tgz"
  sha256 "2455cfaeb7ac70338b3257f41e21f0724f4b5b0c0e7702da67ee6c3640835b67"
  license "BSD-3-Clause"
  revision 1

  depends_on "python@3.11" # or the Python version you are using
  depends_on "libxml2"
  depends_on "libxslt"

  def install
    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    venv.pip_install buildpath/"."
    bin.install_symlink libexec/"bin/lxml"
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
