# CMakeLists.txt
cmake_minimum_required(VERSION 3.0)
project(ign_test)

find_package(ignition-math2 REQUIRED)
find_library(IGN_MATH_LIBRARY ignition-math2 REQUIRED)
# does not work
# find_path(IGN_MATH_INCLUDE_DIR ignition/math2/ignition/math/math.hh)

include_directories(${IGNITION-MATH_INCLUDE_DIRS})
link_libraries(${IGNITION-MATH_LIBRARIES})
add_executable(main main.cpp)
