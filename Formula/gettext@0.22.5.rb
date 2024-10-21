class GettextAT0225 < Formula
  desc "GNU internationalization (i18n) and localization (l10n) library"
  homepage "https://www.gnu.org/software/gettext/"
  url "https://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.gz"
  mirror "https://ftpmirror.gnu.org/gettext/gettext-0.22.5.tar.gz"
  mirror "http://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.gz"
  sha256 "ec1705b1e969b83a9f073144ec806151db88127f5e40fe5a94cb6c8fa48996a0"
  license "GPL-3.0-or-later"

  keg_only :versioned_formula

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  depends_on "fontconfig"
  depends_on "glib"
  depends_on "gtk+4"
  depends_on "shared-mime-info"
  depends_on "z80oolong/dep/polkit@125"
  depends_on "intltool"
  depends_on "libunistring"
  depends_on "z80oolong/eaw/ncurses-eaw@6.2"
  depends_on "libxml2"
  depends_on "git"
  depends_on "xz"
  depends_on "emacs"

  def install
    args = [
      "--disable-silent-rules",
      "--with-libintl-prefix=#{Formula["intltool"].opt_prefix}",
      "--with-libunistring-prefix=#{Formula["libunistring"].opt_prefix}",
      "--with-ncurses-prefix=#{Formula["z80oolong/eaw/ncurses-eaw@6.2"].opt_prefix}",
      "--with-emacs",
      "--with-lispdir=#{elisp}",
      "--disable-java",
      "--disable-csharp",
      "--with-git",
      "--without-cvs",
      "--with-xz",
    ]
    args << if OS.mac?
      "--with-included-gettext"
    else
      "--with-libxml2-prefix=#{Formula["libxml2"].opt_prefix}"
    end

    system "./configure", *std_configure_args, *args
    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make", "install"
  end

  def post_install
    symlink_its("fontconfig", "fontconfig")
    symlink_its("glib", "gschema")
    symlink_its("gtk+4", "gtk4builder")
    symlink_its("shared-mime-info", "shared-mime-info")
    symlink_its("z80oolong/dep/polkit@125", "polkit")
  end

  def symlink_its(formula_name, itsname)
    ohai "Remove #{share}/gettext-#{version}/its/#{itsname}.{its, loc}"
    (share/"gettext-#{version}/its/#{itsname}.its").delete if (share/"gettext-#{version}/its/#{itsname}.its").exist?
    (share/"gettext-#{version}/its/#{itsname}.loc").delete if (share/"gettext-#{version}/its/#{itsname}.loc").exist?
    ohai "Symlink #{Formula[formula_name].opt_share}/gettext/its/#{itsname}.its => #{share}/gettext-#{version}/its/#{itsname}.{its, loc}"
    (share/"gettext-#{version}/its").install_symlink(Formula[formula_name].opt_share/"gettext/its/#{itsname}.its")
    (share/"gettext-#{version}/its").install_symlink(Formula[formula_name].opt_share/"gettext/its/#{itsname}.loc")
  end
  private :symlink_its

  test do
    system bin/"gettext", "test"
  end
end
