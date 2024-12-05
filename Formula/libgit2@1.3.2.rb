class Libgit2AT132 < Formula
  desc "C library of Git core methods that is re-entrant and linkable"
  homepage "https://libgit2.github.com/"
  url "https://github.com/libgit2/libgit2/archive/refs/tags/v1.3.2.tar.gz"
  sha256 "3a4469b32b73d53f9dbb7bf17b61b0cfb7dae9020e199f928fa96f12d6eb29cb"
  license "GPL-2.0-only" => { with: "GCC-exception-2.0" }

  keg_only :versioned_formula

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libssh2"
  depends_on "openssl@3"

  def install
    args  = std_cmake_args
    args << "-DBUILD_EXAMPLES=OFF"
    args << "-DBUILD_TESTS=OFF"
    args << "-DUSE_SSH=ON"
    args << "-DBUILD_SHARED_LIBS=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end

    args.delete "-DBUILD_SHARED_LIBS=ON"
    args << "-DBUILD_SHARED_LIBS=OFF"

    mkdir "build-static" do
      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end

    ohai "Install ./build-static/libgit2.a => #{lib}/libgit2.a"
    lib.install "build-static/libgit2.a"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <git2.h>
      #include <assert.h>

      int main(int argc, char *argv[]) {
        int options = git_libgit2_features();
        assert(options & GIT_FEATURE_SSH);
        return 0;
      }
    EOS
    libssh2 = Formula["libssh2"]
    flags = %W[
      -I#{include}
      -I#{libssh2.opt_include}
      -L#{lib}
      -lgit2
    ]
    system ENV.cc, "test.c", "-o", "test", *flags
    system "./test"
  end
end
