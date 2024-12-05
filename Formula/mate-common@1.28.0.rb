class MateCommonAT1280 < Formula
  desc "Common build files for MATE desktop environment"
  homepage "https://github.com/mate-desktop/mate-common"
  url "https://github.com/mate-desktop/mate-common/archive/refs/tags/v1.28.0.tar.gz"
  sha256 "7100ecd60a9b5f398b9c3508eb17bca657bb748a74fc9f277b1e5ba1e022b701"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    ENV["LC_ALL"] = "C"

    system "./autogen.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
