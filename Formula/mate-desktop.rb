class MateDesktop < Formula
  desc "Common build files for MATE desktop environment"
  homepage "https://github.com/mate-desktop/mate-common"
  url "https://github.com/mate-desktop/mate-desktop/releases/download/v1.27.1/mate-desktop-1.27.1.tar.xz"
  sha256 "eb194b0525c2b49b22f44e767d38ababa2139bf9caa7dc209e6f93abd76364ea"

  depends_on "pkg-config" => :build
  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "gtk-doc" => :build
  depends_on "z80oolong/dep/autoconf-archive@2023" => :build
  depends_on "z80oolong/dep/mate-common@1.24.0" => :build
  depends_on "glibc"
  depends_on "gettext"
  depends_on "intltool"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "gdk-pixbuf"
  depends_on "startup-notification"
  depends_on "z80oolong/dep/dconf@0"

  def install
    aclocal_flags =  ""
    aclocal_flags << "-I #{Formula["z80oolong/dep/autoconf-archive@2023"].opt_share}/aclocal "
    aclocal_flags << "-I #{Formula["z80oolong/dep/mate-common@1.24.0"].opt_share}/aclocal"
    ENV["ACLOCAL_FLAGS"] = aclocal_flags

    system "./autogen.sh", "--prefix=#{prefix}", "--sysconfdir=#{etc}", "--localstatedir=#{var}"
    system "make"
    system "make", "install"
    system "rm", "#{share}/glib-2.0/schemas/gschemas.compiled"
  end

  def post_install
    Dir.chdir("#{HOMEBREW_PREFIX}/share/glib-2.0/schemas") do
      system "#{Formula["glib"].opt_bin}/glib-compile-schemas", "--targetdir=.", "."
    end
  end

  test do
    system "false"
  end
end
