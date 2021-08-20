class Colmap < Formula
  desc "COLMAP - Structure-from-Motion and Multi-View Stereo"
  homepage "https://colmap.github.io"
  url "https://github.com/colmap/colmap/archive/refs/tags/3.6.zip"
  sha256 "dde184ab37b4cfa3f96210780ba88a26949051963303d180264f468760185565"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "git"
  depends_on "boost"
  depends_on "eigen"
  depends_on "freeimage"
  depends_on "glog"
  depends_on "gflags"
  depends_on "suite-sparse"
  depends_on "ceres-solver"
  depends_on "qt@5"
  depends_on "glew"
  depends_on "cgal"

  def install
    mkdir "build" do
      # ENV["CMAKE_PREFIX_PATH"] = "#{Formula["qt@5"].lib}/cmake"
      system "cmake", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end

  test do
    system "colmap --help"
  end
end
