class XfconfAT4193 < Formula
  desc "Xfce configuration storage system"
  homepage "https://docs.xfce.org/xfce/xfconf/start"
  url "https://archive.xfce.org/src/xfce/xfconf/4.19/xfconf-4.19.3.tar.bz2"
  sha256 "3f829221a6b5aa5609470959f58d10c32fccff8036d735ed458a79a795436713"
  license "GPL-2.0-or-later"

  keg_only :versioned_formula

  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "z80oolong/dep/xfce4-dev-tools@4.19.3" => :build
  depends_on "z80oolong/dep/libxfce4util@4.19.3"
  depends_on "gobject-introspection"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gtk-doc"
  depends_on "dbus"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/xfconf-query", "--help"
  end
end
