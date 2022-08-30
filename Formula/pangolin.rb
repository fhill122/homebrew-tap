class Pangolin < Formula
  desc "Library for managing OpenGL display / interaction and abstracting video input"
  homepage "https://github.com/stevenlovegrove/Pangolin"
  url "https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.6.tar.gz"
  # sha256 "a680d1b52cd432f93f3359cb8f2179b25acf384d29dbaa2530b2eb3dfe5a81c6" # v0.8
  sha256 "2fe0f7242bee9b7241a73d17878fe25179f22b07a18d02dec069e4c90890e9d5" # v0.6
  license "MIT"

  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "glew"

  def install
    mkdir "build" do
    # ENV["CMAKE_PREFIX_PATH"] = "#{Formula["qt@5"].lib}/cmake"
    system "cmake", "..", *std_cmake_args, "-DBUILD_PANGOLIN_FFMPEG=OFF"
    system "make"
    system "make", "install"
    end
  end

  test do
    system "true"
  end
end
