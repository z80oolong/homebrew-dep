class PolkitAT125 < Formula
  desc "polkit (formerly PolicyKit) is a toolkit for defining and handling authorizations. It is used for allowing unprivileged processes to speak to privileged processes."
  homepage ""
  url "https://github.com/polkit-org/polkit/archive/refs/tags/125.tar.gz"
  sha256 "ea5cd6e6e2afa6bad938ee770bf0c2cd9317910f37956faeba2869adcf3747d1"
  version "125"
  license "GPL-2"

  keg_only :versioned_formula

  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "gobject-introspection"
  depends_on "pcre2"
  depends_on "libxslt"
  depends_on "gettext"

  def install
    system "meson", "setup", "build", *std_meson_args, "-Dman=true"
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    system "false"
  end
end
