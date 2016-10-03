# Common Ambient Variables:
#   VCPKG_ROOT_DIR = <C:\path\to\current\vcpkg>
#   TARGET_TRIPLET is the current triplet (x86-windows, etc)
#   PORT is the current port name (zlib, etc)
#   CURRENT_BUILDTREES_DIR = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR  = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#

include(${CMAKE_TRIPLET_FILE})
include(vcpkg_common_functions)
vcpkg_download_distfile(ARCHIVE
    URLS "http://gazebosim.org/distributions/ign-math/releases/ignition-math2-2.5.0.tar.bz2"
    FILENAME "ignition-math2-2.5.0.tar.bz2"
    SHA512 6688212debe411fdf7ce201ac443e1acf3e0c21f5e86f750758d8d6d8bf0c89de9d07c708429c11c0835c03dec217ddce292cb258aadbd806ce3a6115e0eb18c
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/ignition-math2-2.5.0
    # OPTIONS -DUSE_THIS_IN_ALL_BUILDS=1 -DUSE_THIS_TOO=2
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_build_cmake()
vcpkg_install_cmake()


# avoid a copy of include file in debug
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${CURRENT_BUILDTREES_DIR}/src/ignition-math2-2.5.0/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/ignition-math2)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/ignition-math2/LICENSE ${CURRENT_PACKAGES_DIR}/share/ignition-math2/copyright)

file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/cmake ${CURRENT_PACKAGES_DIR}/debug/cmake)
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/cmake ${CURRENT_PACKAGES_DIR}/cmake)

# Move dlls to bin/
file(RENAME ${CURRENT_PACKAGES_DIR}/lib/ignition-math2.dll ${CURRENT_PACKAGES_DIR}/bin/ignition-math2.dll)
file(RENAME ${CURRENT_PACKAGES_DIR}/debug/lib/ignition-math2.dll ${CURRENT_PACKAGES_DIR}/debug/bin/ignition-math2.dll)

set(pkg_dir ${CURRENT_PACKAGES_DIR})
if (NOT EXISTS ${pkg_dir}/share/ignition-math2)
  file(MAKE_DIRECTORY "${pkg_dir}/share/ignition-math2")
endif()
file(GLOB_RECURSE CMAKE_RELEASE_FILES 
                  "${pkg_dir}/cmake/ignition-math2/*")
file(COPY ${CMAKE_RELEASE_FILES} DESTINATION 
         "${pkg_dir}/share/ignition-math2/")
file(REMOVE_RECURSE ${pkg_dir}/cmake/ignition-math2/)
file(REMOVE_RECURSE ${pkg_dir}/debug/cmake/ignition-math2/)
