# Note that this script can accept some limited command-line arguments, run
# `julia build_tarballs.jl --help` to see a usage message.
using BinaryBuilder

# Collection of sources required to build CglBuilder
sources = [
    "http://ftpmirror.gnu.org/gnu/glpk/glpk-4.64.tar.gz" =>
    "539267f40ea3e09c3b76a31c8747f559e8a097ec0cda8f1a3778eec3e4c3cc24",

]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir
cd glpk-4.64/
./configure --prefix=$prefix --host=$target
make
make install

"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = [
    Linux(:x86_64, :glibc)
]

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libglpk", :libglpk)
]

# Dependencies that must be installed before this package can be built
dependencies = [
    
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "CglBuilder", sources, script, platforms, products, dependencies)

