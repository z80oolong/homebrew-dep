class LibdbusmenuAT1604 < Formula
  desc "This formula is build for libdbusmenu"
  homepage "https://launchpad.net/libdbusmenu"
  url "https://launchpad.net/libdbusmenu/16.04/16.04.0/+download/libdbusmenu-16.04.0.tar.gz"
  sha256 "b9cc4a2acd74509435892823607d966d424bd9ad5d0b00938f27240a1bfa878a"

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "gtk-doc" => :build
  depends_on "intltool" => :build
  depends_on "dbus"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gdk-pixbuf"
  depends_on "json-glib"
  depends_on "glibc"
  depends_on "vala"

  def install
    args  = std_configure_args
    args << "--disable-silent-rules"
    args << "--disable-dumper"

    system "./configure", *args
    system "make", "install"
  end

  test do
    system "#{bin}/dbusmenu-jsonloader", "--help"
  end
end
