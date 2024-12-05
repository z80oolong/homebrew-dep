class XcbImdkitAT109 < Formula
  desc "Input method framework for X11, part of the Fcitx5 project"
  homepage "https://github.com/fcitx/xcb-imdkit"
  url "https://github.com/fcitx/xcb-imdkit/archive/refs/tags/1.0.9.tar.gz"
  sha256 "c2f0bbad8a335a64cdc7c19ac7b6ea1f0887dd6300ca9a4fa2e2fec6b9d3f695"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "extra-cmake-modules" => :build
  depends_on "pkg-config" => :build
  depends_on "libxcb"
  depends_on "xcb-proto"
  depends_on "xorgproto"

  def install
    args  = std_cmake_args
    args << "-DBUILD_SHARED_LIBS=ON"
    args << "-DUSE_SYSTEM_UTHASH=OFF"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    assert_predicate lib/"libxcb-imdkit.so", :exist?
  end
end
