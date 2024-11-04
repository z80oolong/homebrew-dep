class Libwnck3AT336 < Formula
  desc "Library for writing pagers and tasklists"
  homepage "https://gitlab.gnome.org/GNOME/libwnck"
  url "https://download.gnome.org/sources/libwnck/3.36/libwnck-3.36.0.tar.xz"
  sha256 "bc508150b3ed5d22354b0e6774ad4eee465381ebc0ace45eb0e2d3a4186c925f"

  keg_only :versioned_formula

  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gobject-introspection"
  depends_on "startup-notification"
  depends_on "glibc"
  depends_on "gtk+3"
  depends_on "pcre"
  depends_on "glib"

  def install
    mkdir "build" do
      system "meson", *std_meson_args, ".."
      system "ninja"
      system "ninja", "install"
    end
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <libwnck/libwnck.h>

      int main(int argc, char *argv[]) {
        if (!wnck_init())
          return 1;

        wnck_shutdown();

        return 0;
      }
    EOS
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lwnck-3", "test.c", "-o", "test"
    system "./test"
  end
end
