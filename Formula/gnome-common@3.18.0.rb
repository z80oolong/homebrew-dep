class GnomeCommonAT3180 < Formula
  desc "Core files for GNOME"
  homepage "https://gitlab.gnome.org/GNOME/gnome-common"
  url "https://download.gnome.org/sources/gnome-common/3.18/gnome-common-3.18.0.tar.xz"
  sha256 "22569e370ae755e04527b76328befc4c73b62bfd4a572499fde116b8318af8cf"
  license "GPL-2.0-or-later"

  keg_only :versioned_formula

  def install
    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end
end
