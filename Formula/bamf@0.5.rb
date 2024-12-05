class BamfAT05 < Formula
  desc "Bag of Auxiliary Metadata Files"
  homepage "https://gitlab.gnome.org/GNOME/bamf"
  url "git://git.launchpad.net/bamf",
      tag:      "0.5.6",
      revision: "1b0c6924a13f2facdf8539dca9430bc72c0acc3f"

  keg_only :versioned_formula

  depends_on "autoconf" => :build
  depends_on "automake" => :build
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
  depends_on "systemd"
  depends_on "z80oolong/dep/libwnck3@3.36"

  def install
    ENV["LC_ALL"] = "C"
    ENV["PYTHON"] = Formula["python@3.11"].opt_bin/"python3.11"
    ENV.prepend_path "PYTHONPATH",
      Formula["z80oolong/dep/lxml@5.3"].opt_libexec/"lib/python3.11/site-packages"
    inreplace "./data/Makefile.am",
      %r{^systemddir = /usr/lib/systemd/user}, "systemddir = #{lib}/systemd/user"

    system "autoupdate"
    system "sh", "./autogen.sh"

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
