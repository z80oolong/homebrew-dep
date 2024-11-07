class LibconfuseAT33 < Formula
  desc "Small configuration file parser library for C."
  homepage "https://www.nongnu.org/confuse/manual/"
  url "https://github.com/libconfuse/libconfuse/releases/download/v3.3/confuse-3.3.tar.xz"
  sha256 "1dd50a0320e135a55025b23fcdbb3f0a81913b6d0b0a9df8cc2fdf3b3dc67010"
  license "ISC"

  depends_on "libtool" => :build
  depends_on "flex" => :build
  depends_on "doxygen" => :build
  depends_on "xmlto" => :build
  depends_on "gettext"

  def install
    system "./configure", "--disable-silent-rules", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
