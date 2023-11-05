class CtplAT034 < Formula
  desc "command-line template parsing utility"
  homepage "http://ctpl.tuxfamily.org/"
  url "http://download.tuxfamily.org/ctpl/releases/ctpl-0.3.4.tar.gz"
  version "0.3.4"
  sha256 "3a95fdd03437ed3ae222339cb0de2d2c1240d627faa6c77bf46f1a9b761729fb"

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
