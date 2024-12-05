class GnomeMenusAT336 < Formula
  desc "Bag of Auxiliary Metadata Files"
  homepage "https://packages.ubuntu.com/source/focal/gnome-menus"
  url "git://git.launchpad.net/~ubuntu-desktop/ubuntu/+source/gnome-menus",
      tag:      "ubuntu/3.36.0-1ubuntu1",
      revision: "1616bac40677ae209ea82323585a0721862b5da4"
  version "3.36.0"

  keg_only :versioned_formula

  depends_on "gtk-doc" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "python@3.11" => :build
  depends_on "vala" => :build
  depends_on "z80oolong/dep/gnome-common@3.18.0" => :build
  depends_on "z80oolong/dep/lxml@5.3" => :build
  depends_on "glib"
  depends_on "gtk+3"
  depends_on "libgtop"
  depends_on "libx11"
  depends_on "libxcomposite"
  depends_on "libxdamage"
  depends_on "libxext"
  depends_on "libxfixes"
  depends_on "libxrender"
  depends_on "startup-notification"

  def install
    ENV["PYTHON"] = Formula["python@3.11"].opt_bin/"python3.11"
    ENV.prepend_path "PYTHONPATH", Formula["z80oolong/dep/lxml@5.3"].opt_prefix/"libexec/lib/python3.11/site-packages"

    args  = std_configure_args
    args << "--disable-silent-rules"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "false"
  end
end
