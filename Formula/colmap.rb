class Colmap < Formula
  desc "Structure-from-Motion and Multi-View Stereo"
  homepage "https://colmap.github.io"
  url "https://github.com/colmap/colmap/archive/refs/tags/3.6.tar.gz"
  sha256 "ea22d026a3b13d339551319f4562fe1471b7232433695970704669755031a192"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "eigen"
  depends_on "freeimage"
  depends_on "gflags"
  depends_on "glog"
  depends_on "qt@5"
  depends_on "ceres-solver"
  depends_on "glew"
  depends_on "cgal"
  depends_on "suite-sparse"

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
