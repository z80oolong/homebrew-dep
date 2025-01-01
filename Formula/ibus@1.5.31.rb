class IbusAT1531 < Formula
  include Language::Python::Virtualenv

  desc "Intelligent Input Bus for Linux / Unix OS"
  homepage "https://github.com/ibus/ibus"
  url "https://github.com/ibus/ibus/archive/refs/tags/1.5.31.tar.gz"
  sha256 "1d93df0bd0d9581decb8f0c85fe3b2d248878140c6e5a7cd8ca459c72f75870c"
  license "GPL-2.0-or-later"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "gettext" => :build
  depends_on "glib" => :build
  depends_on "gtk-doc" => :build
  depends_on "intltool" => :build
  depends_on "perl" => :build
  depends_on "dbus-glib"
  depends_on "gobject-introspection"
  depends_on "gtk+3"
  depends_on "libnotify"
  depends_on "libx11"
  depends_on "libxfixes"
  depends_on "libxkbcommon"
  depends_on "pango"
  depends_on "python@3.11"
  depends_on "vala"
  depends_on "z80oolong/dep/libdbusmenu@16.04"
  depends_on "z80oolong/dep/unicode-data@15"

  def install
    virtualenv_create(libexec, "python3")

    emoji_dir = Formula["z80oolong/dep/unicode-data@15"].opt_share/"unicode/emoji"
    ucd_dir   = Formula["z80oolong/dep/unicode-data@15"].opt_share/"unicode-data"
    cldr_dir  = Formula["z80oolong/dep/unicode-data@15"].opt_share/"unicode/cldr"
    anno_dir  = cldr_dir/"common/annotations"

    args  = std_configure_args
    args << "--sysconfdir=#{etc}"
    args << "--localstatedir=#{var}"
    args << "--disable-python2"
    args << "--with-python=python3"
    args << "--with-python_prefix=#{libexec}"
    args << "--disable-maintainer-mode"
    args << "--disable-wayland"
    args << "--disable-gtk2"
    args << "--disable-gtk4"
    args << "--disable-schemas-compile"
    args << "--disable-systemd-services"
    args << "--disable-setup"
    args << "--disable-engine"
    args << "--enable-memconf"
    args << "--disable-dconf"
    args << "--with-unicode-emoji-dir=#{emoji_dir}"
    args << "--with-emoji-annotation-dir=#{anno_dir}"
    args << "--with-ucd-dir=#{ucd_dir}"

    xdg_data_dirs = []
    xdg_data_dirs << Formula["z80oolong/dep/libdbusmenu@16.04"].opt_share
    xdg_data_dirs << "#{HOMEBREW_PREFIX}/share"

    ENV["LC_ALL"] = "C"
    ENV["XDG_DATA_DIRS"] = xdg_data_dirs.join(":")

    system "./autogen.sh", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/ibus-daemon", "--version"
  end
end
