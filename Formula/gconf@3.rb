class GconfAT3 < Formula
  desc "GNOME configuration database system"
  homepage "https://projects.gnome.org/gconf/"
  url "https://download.gnome.org/sources/GConf/3.2/GConf-3.2.6.tar.xz"
  sha256 "1912b91803ab09a5eed34d364bf09fe3a2a9c96751fde03a4e0cfa51a04d784c"

  keg_only :versioned_formula
  depends_on "intltool" => :build
  depends_on "perl" => :build
  depends_on "perl-xml-parser" => :build
  depends_on "pkg-config" => :build
  depends_on "dbus"
  depends_on "dbus-glib"
  depends_on "gettext"
  depends_on "glib"
  depends_on "glibc"
  depends_on "gtk+3"
  depends_on "libxml2"
  depends_on "pcre"
  depends_on "polkit"

  def install
    ENV.prepend_path "PERL5LIB", Formula["intltool"].libexec/"lib/perl5"
    ENV.prepend_path "PERL5LIB", Formula["perl-xml-parser"].libexec/"lib/perl5"
    ENV.cxx11
    ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
    ENV.append "LDFLAGS", "-ldl"
    ENV.append "LDFLAGS", "-lm"

    args  = std_configure_args
    args << "--disable-silent-rules"
    args << "--sysconfdir=#{prefix}/etc"
    args << "--disable-orbit"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "#{share}/gconf/schemas", shell_output("#{bin}/gconftool-2 --get-default-source-path").chomp
  end
end
