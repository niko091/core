# See FindClangFormat.cmake
# Variables of interest on this file: ${ClangFormat_VERSION} - ${ClangFormat_EXECUTABLE} and ${ClangTidy_VERSION} - ${ClangTidy_EXECUTABLE}

# Get only C/C++ files for now
file(GLOB_RECURSE
	ALL_SOURCE_FILES
	LIST_DIRECTORIES OFF
	FOLLOW_SYMLINKS
	${CMAKE_SOURCE_DIR}/source/**/*.cpp
	${CMAKE_SOURCE_DIR}/source/**/*.hpp
	${CMAKE_SOURCE_DIR}/source/**/*.h
	${CMAKE_SOURCE_DIR}/source/**/*.c
	${CMAKE_SOURCE_DIR}/source/**/*.cc
	${CMAKE_SOURCE_DIR}/source/**/*.hh
	${CMAKE_SOURCE_DIR}/source/**/*.cxx
	${CMAKE_SOURCE_DIR}/source/**/*.inl
)

file(GLOB_RECURSE
	ALL_TIDY_SOURCE_FILES
	LIST_DIRECTORIES OFF
	FOLLOW_SYMLINKS
	${CMAKE_SOURCE_DIR}/source/**/*.cpp
	${CMAKE_SOURCE_DIR}/source/**/*.c
	${CMAKE_SOURCE_DIR}/source/**/*.cc
	${CMAKE_SOURCE_DIR}/source/**/*.cxx
)

if(ClangTidy_FOUND)
	add_custom_target(
		clang-tidy
		COMMAND ${ClangTidy_EXECUTABLE}
		-p ${CMAKE_BINARY_DIR}
		--checks=-*,bugprone-*,clang-analyzer-*,modernize-use-nullptr,readability-braces-around-statements
		${ALL_TIDY_SOURCE_FILES}
	)
endif()

if(ClangFormat_FOUND)
	add_custom_target(
		clang-format
		COMMAND ${ClangFormat_EXECUTABLE}
		--verbose
		-style=file
		-i
		${ALL_SOURCE_FILES}
	)
endif()
