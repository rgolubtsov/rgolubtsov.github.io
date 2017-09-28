#
# Makefile
# =============================================================================
# Screen Capture. Version 0.1
# =============================================================================
# Written by Radislav (Radicchio) Golubtsov, 2017
#

# Compile: cl (Microsoft (R) C/C++ Optimizing Compiler Version 19.10.25019)
# -----------------------------------------------------------------------------
# > "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC      \
#      \Tools\MSVC\14.10.25017\bin\HostX64\x64\cl"                            \

# Link: link (Microsoft (R) Incremental Linker Version 14.10.25019.0)
# -----------------------------------------------------------------------------
# > "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC      \
#      \Tools\MSVC\14.10.25017\bin\HostX64\x64\link"                          \

GLOB = ScreenCapture
EXEC = $(GLOB).exe
DEPS = $(GLOB).obj
OBJS = stdafx.obj              \
       SCConfig.obj            \
       StreamUtils.obj         \
       StreamFactory.obj       \
       OutputStream.obj        \
       InputStream.obj         \
       FileOutputStream.obj    \
       FileInputStream.obj     \
       Vector4.obj             \
       Vector3.obj             \
       Vector2.obj             \
       RGBColor.obj            \
       LogStdOutput.obj        \
       LogFileOutput.obj       \
       Log.obj                 \
       Value.obj               \
       SolidusEscaper.obj      \
       JsonWritingError.obj    \
       JsonParsingError.obj    \
       Indenter.obj            \
       IndentCanceller.obj     \
       Escaper.obj             \
       Convert.obj             \
       Environment.obj         \
       Application.obj         \
       SCVideoCompressor.obj   \
       SCUpload.obj            \
       SCSystemInformation.obj \
       SCCapture.obj           \
       SCApplication.obj

SRCS = stdafx.cpp                                         \
       SCConfig.cpp                                       \
       "..\..\Core\Core\Stream\StreamUtils.cpp"           \
       "..\..\Core\Core\Stream\StreamFactory.cpp"         \
       "..\..\Core\Core\Stream\OutputStream.cpp"          \
       "..\..\Core\Core\Stream\InputStream.cpp"           \
       "..\..\Core\Core\Stream\File\FileOutputStream.cpp" \
       "..\..\Core\Core\Stream\File\FileInputStream.cpp"  \
       "..\..\Core\Core\Math\Vector\Vector4.cpp"          \
       "..\..\Core\Core\Math\Vector\Vector3.cpp"          \
       "..\..\Core\Core\Math\Vector\Vector2.cpp"          \
       "..\..\Core\Core\Math\RGBColor.cpp"                \
       "..\..\Core\Core\Log\LogStdOutput.cpp"             \
       "..\..\Core\Core\Log\LogFileOutput.cpp"            \
       "..\..\Core\Core\Log\Log.cpp"                      \
       "..\..\Core\Core\JsonBox\src\Value.cpp"            \
       "..\..\Core\Core\JsonBox\src\SolidusEscaper.cpp"   \
       "..\..\Core\Core\JsonBox\src\JsonWritingError.cpp" \
       "..\..\Core\Core\JsonBox\src\JsonParsingError.cpp" \
       "..\..\Core\Core\JsonBox\src\Indenter.cpp"         \
       "..\..\Core\Core\JsonBox\src\IndentCanceller.cpp"  \
       "..\..\Core\Core\JsonBox\src\Escaper.cpp"          \
       "..\..\Core\Core\JsonBox\src\Convert.cpp"          \
       "..\..\Core\Core\Environment.cpp"                  \
       "..\..\Core\Core\Application.cpp"                  \
       SCVideoCompressor.cpp                              \
       SCUpload.cpp                                       \
       SCSystemInformation.cpp                            \
       ScreenCapture.cpp                                  \
       SCCapture.cpp                                      \
       SCApplication.cpp

#LIBS =    uuid.lib \
#          atls.lib \
#       libcpmt.lib \
#       libucrt.lib \
#         d3dx9.lib

CXXPATH = C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Tools\MSVC\14.10.25017\bin\HostX64\x64

ARCH    = X64

I0 = "C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\shared"
I1 = "C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\um"
I2 = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Tools\MSVC\14.10.25017\include"
I3 = "C:\Program Files (x86)\Windows Kits\10\Include\10.0.15063.0\ucrt"
I4 = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Tools\MSVC\14.10.25017\atlmfc\include"
I5 = "C:\Program Files (x86)\Microsoft DirectX SDK (June 2010)\Include"
I6 = "..\..\Core\Core"
I7 = "..\..\Core\Core\JsonBox\include"

L0 = "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\um\x64"
L1 = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Tools\MSVC\14.10.25017\atlmfc\lib\x64"
L2 = "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Tools\MSVC\14.10.25017\lib\x64"
L3 = "C:\Program Files (x86)\Windows Kits\10\Lib\10.0.15063.0\ucrt\x64"
L4 = "C:\Program Files (x86)\Microsoft DirectX SDK (June 2010)\Lib\x64"

# Specify flags and other vars here.
# The following standards-compliance options work well with g++ 5.1.0
# (TDM-GCC: tdm64-1 -- http://tdm-gcc.tdragon.net):
#CXX_STD  = c++03 # Same as c++98, same as -ansi .
#CXX_STD  = c++11
#CXX_STD  = c++14

#CXX      = g++
#CXXFLAGS = -Wall -pedantic -std=$(CXX_STD) -O3                         \
#           -march=x86-64 -mtune=generic -pipe -fstack-protector-strong \
#           -I$(I0)                                                     \
#           -I$(I1)                                                     \
#           -I$(I2)                                                     \
#           -I$(I3)                                                     \
#           -I$(I4)                                                     \
#           -I$(I5)                                                     \
#           -I$(I6)                                                     \
#           -I$(I7)

#LDLIBS   = -lstdc++

CXX      = cl

# Highly important to define this! ---+
#                                     |
#                     +---------------+
#                     |
#                     V
CXXFLAGS = -D_USING_V110_SDK71_  \
           -D_WIN32_WINNT=0x0A00 \
           -EHsc                 \
           -Ox                   \
           -D_WINDOWS            \
           -D_UNICODE            \
           -DUNICODE             \
           -I$(I0)               \
           -I$(I1)               \
           -I$(I2)               \
           -I$(I3)               \
           -I$(I4)               \
           -I$(I5)               \
           -I$(I6)               \
           -I$(I7)

LNK      = link
LNKFLAGS = -MACHINE:$(ARCH) \
           -LIBPATH:$(L0) \
           -LIBPATH:$(L1) \
           -LIBPATH:$(L2) \
           -LIBPATH:$(L3) \
           -LIBPATH:$(L4)

RM       = del

# Making the target.
#$(DEPS): CXXFLAGS += -c -o
#$(DEPS): %.obj: %.cpp
#	$(CXX) $(CXXFLAGS) $@ $<
#	"$(CXXPATH)\$(CXX)" $(CXXFLAGS) $@ $<
$(DEPS): CXXFLAGS += -c
$(DEPS):
	"$(CXXPATH)\$(CXX)" $(CXXFLAGS) $(SRCS)

$(EXEC): LNKFLAGS += -OUT:
$(EXEC): $(DEPS)
#	$(CXX) -o $(EXEC) $(DEPS)
	"$(CXXPATH)\$(LNK)" $(LNKFLAGS)$(EXEC) $(LIBS) $(DEPS) $(OBJS)

.PHONY: all clean

all: $(EXEC)

clean:
	$(RM) $(EXEC) $(DEPS)

# vim:set nu:et:ts=4:sw=4:
