# TODO: Get the CMakeLists.txt to generate the makefile
#This CMake file currently does not work. It may be easier to just make a regular makefile manually for each operating system

cmake_minimum_required (VERSION 2.6) 
project(Parallelized Python Module)
#copied from this answer: https://stackoverflow.com/questions/1620918/cmake-and-libpthread?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
find_package (Threads)
set(SOURCE_FILES
   test_array_reversal.cpp,
   Array_Reversal.h
)
add_executable(test_array_reversal.exe ${SOURCE_FILES})
target_link_libraries (test_array_reversal.exe ${CMAKE_THREAD_LIBS_INIT})