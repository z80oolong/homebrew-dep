class FcitxAT5110 < Formula
  desc "New version of Flexible Input Method Framework"
  homepage "https://github.com/fcitx/fcitx5"
  url "https://github.com/fcitx/fcitx5/archive/refs/tags/5.1.10.tar.gz"
  sha256 "a33f71e60a840b37fed7b04d2dcc7544a89bda78e4f4b2df7946ff358032a903"
  license "GPL-2.0-or-later"

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "gettext" => :build
  depends_on "pkg-config" => :build
  depends_on "glib"
  depends_on "glibc"
  depends_on "gobject-introspection"
  depends_on "gtk+"
  depends_on "gtk+3"
  depends_on "intltool"
  depends_on "json-c"
  depends_on "librsvg"
  depends_on "libxkbcommon"
  depends_on "libxml2"
  depends_on "pcre"
  depends_on "sdl12-compat"
  depends_on "sqlite"
  depends_on "z80oolong/dep/xcb-imdkit@1.0.9"

  resource("fcitx5-gclient") do
    url "https://github.com/fcitx/fcitx5-gtk/archive/refs/tags/5.1.3.tar.gz"
    sha256 "1892fcaeed0e710cb992a87982a8af78f9a9922805a84da13f7e3d416e2a28d1"
  end

  def install
    args  = std_cmake_args.dup
    args << "-DENABLE_X11=ON"
    args << "-DENABLE_WAYLAND=OFF"
    args << "-DENABLE_SERVER=OFF"
    args << "-DUSE_SYSTEMD=OFF"
    args << "-DENABLE_LIBUUID=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end

    resource("fcitx5-gclient").stage do
      ENV.prepend_path "PKG_CONFIG_PATH", lib/"pkgconfig"

      args  = std_cmake_args
      args << "-DENABLE_GIR=ON"
      args << "-DENABLE_GTK2_IM_MODULE=ON"
      args << "-DENABLE_GTK3_IM_MODULE=ON"
      args << "-DENABLE_GTK4_IM_MODULE=OFF"
      args << "-DENABLE_SNOOPER=OFF"

      mkdir "build" do
        system "cmake", "..", *args
        system "make"
        system "make", "install"
      end
    end
  end

  test do
    system "false"
  end
end
