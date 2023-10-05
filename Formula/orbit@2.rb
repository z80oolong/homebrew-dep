class OrbitAT2 < Formula
  desc "CORBA 2.4-compliant Object Request Broker (ORB)"
  homepage "https://wiki.gnome.org/Projects/ORBit2"
  url "https://download.gnome.org/sources/ORBit2/2.14/ORBit2-2.14.19.tar.bz2"
  sha256 "55c900a905482992730f575f3eef34d50bda717c197c97c08fa5a6eafd857550"

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "libidl"

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--enable-shared",
                          "--disable-static",
                          "--disable-gtk-doc"
    system "make", "install"
  end
end
