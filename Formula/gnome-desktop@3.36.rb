class GnomeDesktopAT336 < Formula
  include Language::Python::Virtualenv

  desc "Desktop utils for GNOME"
  homepage "https://packages.ubuntu.com/source/focal/gnome-menus"
  url "git://git.launchpad.net/~ubuntu-desktop/ubuntu/+source/gnome-menus",
      tag:      "ubuntu/3.36.0-1ubuntu1",
      revision: "1616bac40677ae209ea82323585a0721862b5da4"
  version "3.36.0"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "gtk-doc" => :build
  depends_on "libtool" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.11" => :build
  depends_on "vala" => :build
  depends_on "z80oolong/dep/lxml@5.3" => :build
  depends_on "glib"
  depends_on "glibc"
  depends_on "gobject-introspection"
  depends_on "gtk+3"
  depends_on "libgtop"
  depends_on "libx11"
  depends_on "libxcomposite"
  depends_on "libxdamage"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "libxml2"
  depends_on "libxrender"
  depends_on "libxslt"
  depends_on "pcre"
  depends_on "startup-notification"

  resource("libwnck3") do
    url "https://download.gnome.org/sources/libwnck/3.36/libwnck-3.36.0.tar.xz"
    sha256 "bc508150b3ed5d22354b0e6774ad4eee465381ebc0ace45eb0e2d3a4186c925f"
  end

  resource("gnome-common") do
    url "https://download.gnome.org/sources/gnome-common/3.18/gnome-common-3.18.0.tar.xz"
    sha256 "22569e370ae755e04527b76328befc4c73b62bfd4a572499fde116b8318af8cf"
  end

  def install
    ENV["LC_ALL"] = "C"
    ENV["PYTHON"] = Formula["python@3.11"].opt_bin/"python3.11"
    ENV.prepend_path "PYTHONPATH",
      Formula["z80oolong/dep/lxml@5.3"].libexec/"lib/python3.11/site-packages"

    resource("libwnck3").stage do
      system "meson", "setup", "build", *std_meson_args
      system "meson", "compile", "-C", "build", "--verbose"
      system "meson", "install", "-C", "build"
    end

    args  = std_configure_args
    args << "--disable-silent-rules"

    resource("gnome-common").stage do
      system "./configure", *args
      system "make"
      system "make", "install"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
