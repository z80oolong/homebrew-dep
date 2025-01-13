class MateDesktopAT1280 < Formula
  desc "Common build files for MATE desktop environment"
  homepage "https://github.com/mate-desktop/mate-common"
  url "https://github.com/mate-desktop/mate-desktop/releases/download/v1.28.0/mate-desktop-1.28.0.tar.xz"
  sha256 "3ac74a2ea28e4cc7ab212c23f10ebef573b3eb3ad93d0cbacb4f3f02f0be0447"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "gtk-doc" => :build
  depends_on "icon-naming-utils" => :build
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "pkg-config" => :build
  depends_on "gdk-pixbuf"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gtk+3"
  depends_on "intltool"
  depends_on "startup-notification"
  depends_on "z80oolong/dep/dconf@0"

  resource("autoconf-archive") do
    url "https://ftp.gnu.org/gnu/autoconf-archive/autoconf-archive-2023.02.20.tar.xz"
    mirror "https://ftpmirror.gnu.org/autoconf-archive/autoconf-archive-2023.02.20.tar.xz"
    sha256 "71d4048479ae28f1f5794619c3d72df9c01df49b1c628ef85fde37596dc31a33"
  end

  resource("mate-common") do
    url "https://github.com/mate-desktop/mate-common/archive/refs/tags/v1.28.0.tar.gz"
    sha256 "7100ecd60a9b5f398b9c3508eb17bca657bb748a74fc9f277b1e5ba1e022b701"
  end

  resource("mate-icon-theme") do
    url "https://github.com/mate-desktop/mate-icon-theme/archive/refs/tags/v1.28.0.tar.gz"
    sha256 "6cd3e848131f3ab995bc7c6f8445157d79fcc6b172c0ad2bc0bc8d81bdc8ae0d"
  end

  def install
    ENV["LC_ALL"] = "C"
    ENV["ACLOCAL_FLAGS"] = "-I #{share}/aclocal"
    ENV.prepend_path "PATH", bin

    resource("autoconf-archive").stage do
      system "./configure", *std_configure_args
      system "make"
      system "make", "install"
    end

    resource("mate-common").stage do
      system "./autogen.sh", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end

    resource("mate-icon-theme").stage do
      system "./autogen.sh", "--prefix=#{prefix}"
      system "make"
      system "make", "install"
    end

    system "./autogen.sh", "--prefix=#{prefix}",
      "--sysconfdir=#{etc}", "--localstatedir=#{var}"
    system "make"
    system "make", "install"
  end

  def post_install
    system "#{Formula["glib"].opt_bin}/glib-compile-schemas", share/"glib-2.0/schemas"
  end

  test do
    system "false"
  end
end
