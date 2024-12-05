class Libxfce4uiAT4196 < Formula
  desc "Mirror repository, PRs are not watched, please use Xfce's GitLab"
  homepage "https://gitlab.xfce.org/xfce/libxfce4ui"
  url "https://github.com/xfce-mirror/libxfce4ui/archive/refs/tags/libxfce4ui-4.19.6.tar.gz"
  sha256 "ead04dbb38ea5863625b294ca2dffba57b0fec280328b18b8fb4be035aa1db9a"
  license "LGPL-2.1-or-later"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "glibc"
  depends_on "gobject-introspection"
  depends_on "gtk+3"
  depends_on "intltool"
  depends_on "libgtop"
  depends_on "startup-notification"
  depends_on "z80oolong/dep/libxfce4util@4.19.3"
  depends_on "z80oolong/dep/xfce4-dev-tools@4.19.3"
  depends_on "z80oolong/dep/xfconf@4.19.3"

  def install
    ENV["LC_ALL"] = "C"
    system "./autogen.sh"

    inreplace "./configure" do |s|
      s.gsub!("MAINTAINER_MODE_TRUE='#'", "MAINTAINER_MODE_TRUE=")
      s.gsub!("MAINTAINER_MODE_FALSE=", "MAINTAINER_MODE_FALSE='#'")
    end

    args  = std_configure_args
    args << "--disable-silent-rules"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
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
