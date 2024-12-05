class GettextAT0225 < Formula
  desc "GNU internationalization (i18n) and localization (l10n) library"
  homepage "https://www.gnu.org/software/gettext/"
  url "https://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.gz"
  mirror "https://ftpmirror.gnu.org/gettext/gettext-0.22.5.tar.gz"
  mirror "http://ftp.gnu.org/gnu/gettext/gettext-0.22.5.tar.gz"
  sha256 "ec1705b1e969b83a9f073144ec806151db88127f5e40fe5a94cb6c8fa48996a0"
  license "GPL-3.0-or-later"

  keg_only :versioned_formula

  depends_on "emacs"
  depends_on "fontconfig"
  depends_on "git"
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "intltool"
  depends_on "libunistring"
  depends_on "libxml2"
  depends_on "ncurses"
  depends_on "polkit"
  depends_on "shared-mime-info"
  depends_on "xz"

  uses_from_macos "libxml2"
  uses_from_macos "ncurses"

  def install
    args  = std_configure_args
    args << "--disable-silent-rules"
    args << "--with-libintl-prefix=#{Formula["intltool"].opt_prefix}"
    args << "--with-libunistring-prefix=#{Formula["libunistring"].opt_prefix}"
    args << "--with-ncurses-prefix=#{Formula["ncurses"].opt_prefix}"
    args << "--with-emacs"
    args << "--with-lispdir=#{elisp}"
    args << "--disable-java"
    args << "--disable-csharp"
    args << "--with-git"
    args << "--without-cvs"
    args << "--with-xz"
    args << if OS.mac?
      "--with-included-gettext"
    else
      "--with-libxml2-prefix=#{Formula["libxml2"].opt_prefix}"
    end

    system "./configure", *args
    ENV.deparallelize
    system "make"
    system "make", "install"
  end

  def post_install
    symlink_its "fontconfig", "fontconfig"
    symlink_its "glib", "gschema"
    symlink_its "gtk+4", "gtk4builder"
    symlink_its "shared-mime-info", "shared-mime-info"
    symlink_its "polkit", "polkit"
  end

  def symlink_its(formula_name, itsname)
    if (share/"gettext-#{version}/its/#{itsname}.its").exist?
      ohai "Remove #{share}/gettext-#{version}/its/#{itsname}.its"
      (share/"gettext-#{version}/its/#{itsname}.its").delete
    end

    if (share/"gettext-#{version}/its/#{itsname}.loc").exist?
      ohai "Remove #{share}/gettext-#{version}/its/#{itsname}.loc"
      (share/"gettext-#{version}/its/#{itsname}.loc").delete
    end

    f_opt_share = Formula[formula_name].opt_share
    ohai "Symlink #{f_opt_share}/gettext/its/#{itsname}.its => #{share}/gettext-#{version}/its/#{itsname}.its"
    (share/"gettext-#{version}/its").install_symlink(f_opt_share/"gettext/its/#{itsname}.its")

    ohai "Symlink #{f_opt_share}/gettext/its/#{itsname}.its => #{share}/gettext-#{version}/its/#{itsname}.loc"
    (share/"gettext-#{version}/its").install_symlink(f_opt_share/"gettext/its/#{itsname}.loc")
  end
  private :symlink_its

  test do
    system bin/"gettext", "test"
  end
end
