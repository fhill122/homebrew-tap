class Gtsam < Formula
  desc "C++ Library that implement smoothing and mapping in robotics and vision"
  homepage "https://gtsam.org"
  url "https://github.com/borglab/gtsam/archive/4.0.3.tar.gz"
  sha256 "eaa561749edf7a2d402981828253e28aed6c717dae35738301c5ab23e2595f25"
  license "BSD-3-Clause"

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "eigen"

  def install
    mkdir "build" do
      # note to fix sanitizer memory warning: enable march=native here, in every project using this lib, and every other libs use eigen along with it
      system "cmake", "..", *std_cmake_args, "-DGTSAM_BUILD_WITH_MARCH_NATIVE=OFF", "-DGTSAM_WITH_TBB=OFF", "-DGTSAM_USE_SYSTEM_EIGEN=ON"
      system "make"
      system "make", "install"
    end
    system "ln", "-s", "#{HOMEBREW_PREFIX}/include/eigen3/Eigen", "#{HOMEBREW_PREFIX}/include/Eigen"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <gtsam/geometry/Pose3.h>
      int main(){
          gtsam::Pose3 poseA = gtsam::Pose3::identity();
          gtsam::Pose3 poseB{gtsam::Rot3(gtsam::Quaternion::Identity()), gtsam::Point3(1,0,0)};
          gtsam::Pose3 poseC = poseA.between(poseB);
          return (int)poseC.y();
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++11", "-L#{lib}", "-lgtsam", "-o", "test"
    system "./test"
  end
end
