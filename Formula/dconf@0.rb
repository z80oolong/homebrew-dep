class DconfAT0 < Formula
  desc "Configuration system for Linux desktop environments"
  homepage "https://wiki.gnome.org/Projects/dconf"
  url "https://download.gnome.org/sources/dconf/0.40/dconf-0.40.0.tar.xz"
  sha256 "cf7f22a4c9200421d8d3325c5c1b8b93a36843650c9f95d6451e20f0bcb24533"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "gettext" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "dbus"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "libffi"
  depends_on "libxml2"
  depends_on "systemd"

  def install
    mkdir "build" do
      meson_args  = std_meson_args
      meson_args << "-Dbash_completion=false"
      meson_args << "-Dsystemduserunitdir=#{lib}/systemd/user"
      meson_args << "-Dman=false"
      meson_args << "-Dgtk_doc=false"

      system "meson", *meson_args, ".."
      system "ninja"
      system "ninja", "install", "-v"
    end
  end

  def post_install
    unless (etc/"dconf/db/site.d").exist?
      ohai "Make Directory #{etc}/dconf/db/site.d"
      (etc/"dconf/db/site.d").mkpath
    end

    unless (etc/"dconf/db/distro.d").exist?
      ohai "Make Directory #{etc}/dconf/db/distro.d"
      (etc/"dconf/db/distro.d").mkpath
    end

    unless (etc/"dconf/db/site").exist?
      ohai "Touch #{etc}/dconf/db/site"
      touch etc/"dconf/db/site"
    end

    unless (etc/"dconf/db/distro").exist?
      ohai "Touch #{etc}/dconf/db/distro"
      touch etc/"dconf/db/distro"
    end

    unless (etc/"dconf/db/site.d/.empty").exist?
      ohai "Touch #{etc}/dconf/db/site.d/.empty"
      touch etc/"dconf/db/site.d/.empty"
    end

    unless (etc/"dconf/db/distro.d/.empty").exist?
      ohai "Touch #{etc}/dconf/db/distro.d/.empty"
      touch etc/"dconf/db/distro.d/.empty"
    end

    system bin/"dconf", "update"
  end

  test do
    system bin/"dconf", "--version"
  end
end
