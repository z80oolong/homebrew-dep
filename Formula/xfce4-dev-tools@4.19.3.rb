class Xfce4DevToolsAT4193 < Formula
  desc "Xfce developer tools"
  homepage "https://gitlab.xfce.org/xfce/xfce4-dev-tools"
  url "https://archive.xfce.org/src/xfce/xfce4-dev-tools/4.19/xfce4-dev-tools-4.19.3.tar.bz2"
  sha256 "91ed21adb3083b0bfbfdf40872baefdb4fb4a604eed06251d86935e67e07f6ac"
  license "GPL-2.0-or-later"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "libxslt" => :build
  depends_on "meson" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/xfce4-dev-tools", "--version"
  end
end
