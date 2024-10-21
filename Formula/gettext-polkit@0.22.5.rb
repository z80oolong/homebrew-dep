class GettextPolkitAT0225 < Formula
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

  def install
    args = [
      "--disable-silent-rules",
      "--with-included-glib",
      "--with-included-libcroco",
      "--with-included-libunistring",
      "--with-included-libxml",
      "--with-emacs",
      "--with-lispdir=#{elisp}",
      "--disable-java",
      "--disable-csharp",
      # Don't use VCS systems to create these archives
      "--without-git",
      "--without-cvs",
      "--without-xz",
    ]
    args << if OS.mac?
      # Ship libintl.h. Disabled on linux as libintl.h is provided by glibc
      # https://gcc-help.gcc.gnu.narkive.com/CYebbZqg/cc1-undefined-reference-to-libintl-textdomain
      # There should never be a need to install gettext's libintl.h on
      # GNU/Linux systems using glibc. If you have it installed you've borked
      # your system somehow.
      "--with-included-gettext"
    else
      "--with-libxml2-prefix=#{Formula["libxml2"].opt_prefix}"
    end

    system "./configure", *std_configure_args, *args
    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make", "install"

    (share/"gettext-#{version}/its/polkit.its").write(<<~EOS)
    <?xml version="1.0"?>
    <its:rules xmlns:its="http://www.w3.org/2005/11/its"
               version="2.0">
      <its:translateRule selector="//*" translate="no"/>
      <its:translateRule selector="//action/description |
                                   //action/message"
                         translate="yes"/>
    </its:rules>
    EOS

    (share/"gettext-#{version}/its/polkit.loc").write(<<~EOS)
    <?xml version="1.0"?>
    <locatingRules>
      <locatingRule name="polkit policy" pattern="*.policy">
        <documentRule localName="policyconfig" target="polkit.its"/>
      </locatingRule>
    </locatingRules>
    EOS
  end

  test do
    system bin/"gettext", "test"
  end
end
