class Xfce4DesktopAT4196 < Formula
  desc "Xfce4 desktop tool for XFCE4"
  homepage "https://gitlab.xfce.org/xfce"
  url "https://github.com/xfce-mirror/libxfce4ui/archive/refs/tags/libxfce4ui-4.19.6.tar.gz"
  sha256 "ead04dbb38ea5863625b294ca2dffba57b0fec280328b18b8fb4be035aa1db9a"
  license "LGPL-2.1-or-later"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "libtool" => :build
  depends_on "libxslt" => :build
  depends_on "meson" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build
  depends_on "dbus"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gobject-introspection"
  depends_on "gtk+3"
  depends_on "gtk-doc"
  depends_on "intltool"
  depends_on "libgtop"
  depends_on "startup-notification"

  resource("xfce4-dev-tools") do
    url "https://archive.xfce.org/src/xfce/xfce4-dev-tools/4.19/xfce4-dev-tools-4.19.3.tar.bz2"
    sha256 "91ed21adb3083b0bfbfdf40872baefdb4fb4a604eed06251d86935e67e07f6ac"
  end

  resource("libxfce4util") do
    url "https://github.com/xfce-mirror/libxfce4util/archive/refs/tags/libxfce4util-4.19.3.tar.gz"
    sha256 "eae804d16d80687d15e6dedf5157f1da9be062d26c99f060eff0ecc648259b2f"
  end

  resource("xfconf") do
    url "https://archive.xfce.org/src/xfce/xfconf/4.19/xfconf-4.19.3.tar.bz2"
    sha256 "3f829221a6b5aa5609470959f58d10c32fccff8036d735ed458a79a795436713"
  end

  def install
    ENV["LC_ALL"] = "C"
    ENV.prepend_path "PATH", bin
    ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"

    args  = std_configure_args.dup
    args << "--disable-silent-rules"

    resource("xfce4-dev-tools").stage do
      system "./configure", *args
      system "make"
      system "make", "install"
    end

    resource("libxfce4util").stage do
      system "./autogen.sh"

      inreplace "./configure" do |s|
        s.gsub!("MAINTAINER_MODE_TRUE='#'", "MAINTAINER_MODE_TRUE=")
        s.gsub!("MAINTAINER_MODE_FALSE=", "MAINTAINER_MODE_FALSE='#'")
      end

      system "./configure", *args
      system "make"
      system "make", "install"
    end

    resource("xfconf").stage do
      system "./configure", *args
      system "make"
      system "make", "install"
    end

    system "./autogen.sh"

    inreplace "./configure" do |s|
      s.gsub!("MAINTAINER_MODE_TRUE='#'", "MAINTAINER_MODE_TRUE=")
      s.gsub!("MAINTAINER_MODE_FALSE=", "MAINTAINER_MODE_FALSE='#'")
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/xfce4-dev-tools", "--version"
    system "#{bin}/xfconf-query", "--help"

    (testpath/"test.c").write <<~EOS
      #include <libxfce4ui/libxfce4ui.h>
      int main() {
        xfce_dialog_show_info(NULL, "Hello, world!", "This is a test.");
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-o", "test", "-I#{include}", "-L#{lib}", "-lxfce4ui-2"
    system "./test"
  end
end
