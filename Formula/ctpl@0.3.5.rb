class CtplAT035 < Formula
  desc "command-line template parsing utility"
  homepage "http://ctpl.tuxfamily.org/"
  url "http://download.tuxfamily.org/ctpl/releases/ctpl-0.3.5.tar.gz"
  version "0.3.5"
  sha256 "21108fc7567ed216deea4591adbfece8e88b1f4bb1ca77c37400920644d756be"

  keg_only :versioned_formula

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "ctags"
  depends_on "glib"
  depends_on "gettext"

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
