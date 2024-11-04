class Libxfce4utilAT4193 < Formula
  desc "Mirror repository, PRs are not watched, please use Xfce's GitLab"
  homepage "https://gitlab.xfce.org/xfce/libxfce4util"
  url "https://github.com/xfce-mirror/libxfce4util/archive/refs/tags/libxfce4util-4.19.3.tar.gz"
  sha256 "eae804d16d80687d15e6dedf5157f1da9be062d26c99f060eff0ecc648259b2f"
  license "NOASSERTION"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "z80oolong/dep/xfce4-dev-tools@4.19.3" => :build
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk-doc"

  def install
    ENV["LC_ALL"] ="C"
    system "./autogen.sh"

    inreplace "./configure" do |s|
      s.gsub!(%r{MAINTAINER_MODE_TRUE='#'}, %{MAINTAINER_MODE_TRUE=})
      s.gsub!(%r{MAINTAINER_MODE_FALSE=}, %{MAINTAINER_MODE_FALSE='#'})
    end

    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
