class MateCommonAT1240 < Formula
  desc "Common build files for MATE desktop environment"
  homepage "https://github.com/mate-desktop/mate-common"
  url "https://github.com/mate-desktop/mate-common/archive/v1.24.0.tar.gz"
  sha256 "bec14644185356badeb8076ffbcb32ff3a81e3613645793fe70598f69b5a9fe8"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
