class ScintillaAT534 < Formula
  desc "Full-featured free source code editor control"
  homepage "https://www.scintilla.org/"
  url "https://www.scintilla.org/scintilla534.tgz"
  version "5.3.4"
  sha256 "3f01b1aef2b7e98f628af2cff965876f5d15ee2801d9df96dd3aced8f087cb46"
  license "MIT"

  keg_only :versioned_formula

  depends_on "pkg-config" => :build
  depends_on "gtk+3"

  def install
    Dir.chdir(buildpath/"gtk") do
      system "make", "all", "GTK3=1", "prefix=#{prefix}"
    end

    lib.install buildpath/"bin/libscintilla.so"
    lib.install buildpath/"bin/scintilla.a" => "libscintilla.a"
    include.install Dir[buildpath/"include/*"]
  end

  test do
    assert_predicate lib/"libscintilla.so", :exist?
  end
end
