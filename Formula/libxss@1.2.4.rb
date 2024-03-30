class LibxssAT124 < Formula
  desc "X11 Screen Saver extension library"
  homepage "https://gitlab.freedesktop.org/xorg/lib/libxss"
  url "https://www.x.org/archive/individual/lib/libXScrnSaver-1.2.4.tar.xz"
  sha256 "75cd2859f38e207a090cac980d76bc71e9da99d48d09703584e00585abc920fe"
  license "MIT"

  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "libxext"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "false"
  end
end
