---
weight: 1400
linkTitle: "Code development"
title: "Code Development on Grex"
description: "Everything you need to know about development tools."
categories: ["Software", "Applications"]
banner: true
bannerContent: "__Work in progress.__"
#tags: ["Configuration"]
---

## Introduction
---

Grex comes with a sizable software stack that contains most of the software development environment for typical HPC applications. This section of the documentation covers best practices for compiling and building your own software on Grex.

On Grex, login nodes can be used to compile software and to run short interactive and/or test runs. All other jobs must be submitted to the [batch](running-jobs/batch-jobs) system. User sessions on the login nodes are limited by _cgroups_ to prevent resource congestion. Thus it sometimes makes sense to perform some of the code development in interactive jobs, in cases such as (but not limited to):

 *  **(a)** the build process and/or tests requires heavy, many-core computations
 * **(b)** you need access to specific hardware not present on the login nodes, such as GPUs and newer/different CPUs.

Most of the software on Grex is available through environmental modules. In particular, it is almost always necessary to use _modules_ to load current C, C++, Fortran compilers and Python interpreter. To find a software development tool or a library to build your code against, the __module spider__ command is a good start. The applications software is usually installed by us from sources, into subdirectories under __/global/software__ .

It is almost always better to use communication libraries (MPI) provided on Grex rather than building your own, because ensuring tight integration of these libraries with our SLURM scheduler and low-level, interconnect-specific libraries might be tricky.

## General Linux Base OS notes
---

The base operating system on Grex is a RedHat type of Linux. For many years it used to be a CentOS Linux. Since 2024, twe have switched to [**Alma Linux**](https://almalinux.org/) which is a  community owned and governed, RedHat-style distribution. The current OS is Alma Linux 8.

Alma Linux OS comes with its set of development tools, and RedHat environment does provide various _developer toolsets_ and software channels. However, due to the philosophy of RedHat being stable, server-focused distribution, the tools are usually rather old. For example, __cmake__ and __git__ and _gcc_ and _python_ are always a couple of years behind the current versions. Therefore, even for these basic tools you more likely than non would want to load a module with newest versions of these tools:

{{< highlight bash >}}
module load git
module load cmake
{{< /highlight >}}

Alma Linux  also has its system versions of Python, Perl, and GCC compilers. When no modules are loaded, the binaries of these will be available in the PATH. The purpose of these is to make some systems scripts possible, to compile OS packages, drivers and so on. We suggest using these tools using Modules and one of our Software Stacks instead.

We do not install many packages for the dynamic languages (such as _python-something_) in the base OS level, because it makes maintaining different versions of them complicated. The same advice applies: use the **module spider** command to find a version of Perl, Python, R, etc. to suit your needs. The same applies to compiler suites like GCC and Intel.

We do install AlmaLinux packages with OS that are:

 * base OS packages necessary for functioning
 * graphical libraries that have many dependencies
 * never change versions that are not critical for performance and/or security. 

> * Here are some examples: FLTK, libjpeg, PCRE, Qt and Gtk. Login nodes of Grex have many ''-devel'' packages installed, while compute nodes do not because we want them lean and quickly re-installable. Therefore, compiling codes that requires ''-devel'' base OS packages might fail on compute nodes. Contact us if something like that happens when compiling or running your applications.

Finally, because HPC machines are shared systems and users do not have _sudo_ access, following some instructions from a Web page that asks for _apt-get install this_ or _yum install that_ will fail. Rather, __module spider__ should be used to see if the package you want is already installed and available as a module. If not, you can always contact [support](support) and ask for help to install the program either under your account or as a module when possible. 

## Compilers and Toolchains
---

Due to the hierarchical nature of our **Lmod** modules system, compilers and certain core libraries (MPI and CUDA) form toolchains. Normally, you would need to choose a compiler suite (GCC or Intel or AOCC) and, in case of parallel applications, a MPI library (OpenMPI or IntelMPI). These come in different versions. Also, you'd want to know if you want CUDA should your applications be able to utilize GPUs. A combination of compiler/version, MPI/version and possibly CUDA makes a toolchain. Toolchains are mutually exclusive; you cannot mix software items compiled with different toolchains!

See Using Modules page for more information.

__There is no module loaded by default__! There will be only the system's GCC-8 and no MPI whatsoever. To get started, load an Architecture module, then a compiler/version. Then, if necessary, an MPI (openmpi or intelmpi). If GPUs are required, a CUDA module would be needed to load first because it forms a root of GPU-enabled toolchains. 

A typical sequence of commands to get an environment with new Intel-One compiler and OpenMPI, for AVX512 compute nodes is as follows:

{{< highlight bash >}}
module load arch/avx512
module load intel-one/2024.1
module load openmpi/4.1.6
{{< /highlight >}}

The example below is for GCC 13 and openmpi:

{{< highlight bash >}}
module load arch/avx512
module load gcc/13.2.0
module load ompi/4.1.6
{{< /highlight >}}

> Compiler modules would set standard system environment variables ($CC, $FC and $CXX) for compiler names. The MPI wrappers (__mpicc__, __mpicxx__, __mpif90__ or __mpifort__ ... etc.) will be set correctly by MPI modules to point to the right compilers.


### Intel compilers suite
---

[Intel](https://www.intel.com) had been providing an optimizing compiler suite for Intel x86_64 CPU architectures for many years. Since 2023, the venerable "classic" Intel compilers were gradually discontinued and in 2024 replaced by a new Intel-OneAPI compilers suite based on the open source LLVM/Clang codebase.
The "classic" compilers (__icc__, __icpc__, __ifort__ ) are replaced in the OneAPI suite with the new __icx__, __icpx__, __ifx__ correspondigly.

As a result of our CentOS to AlmaLinux upgrade, all the older Intel compiler versions were obsoleted and removed from the local Grex software stack. 

The name for the Intel suite modules is __intel__; ```module spider intel``` is the command to find available Intel "classic" versions. Latest Intel Classic compilers did include both "classic" and LLVM compilers. 
On Grex local software stack, the name for the new  Intel OneAPI compilers suite modules is __intel-one__; ```module spider intel-one``` is the command to find available Intel OneAPI versions. These will not contain old compilers like __icc__ anymore. 

The Intel compilers suite also provides tools and libraries such as [MKL](https://software.intel.com/en-us/mkl) (Linear Algebra, FFT, etc.), Intel Performance Primitives (IPP), Intel [Threads Building Blocks](https://software.intel.com/en-us/tbb) (TBB), and [VTune](https://software.intel.com/en-us/vtune). Intel MPI as well as MKL for GCC compilers are available as separate modules, should they be needed for use separately.
Both classic and OneAPI compiler suites come with and can use optimized performance libraries: Intel MKL, TBB and IPP.

### GCC compilers suite
---

[GCC](https://gcc.gnu.org/) stands for "GNU Compiler Collection" and includes C, C++ and Fortran languages (as well as many other optionally).

The module name for GCC is __gcc__, as in ```module spider gcc```. 

Multi-lib GCC is not supported, thus all the GCC modules are strictly **64-bit**, and thus unable to compile legacy **32-bit** programs.

Recent GCC versions have a good support for AVX512 CPU instructions on both Intel and AMD CPUs. 
However, care may be taken with ```-march=native``` because the subsets of AVX512 implemented on Intel Cascade Lake and AMD Genoa CPUs may be different, so it does matter on which host a given code had been compiled.

### AOCC comilers suite
---

[AMD AOCC](https://www.amd.com/en/developer/aocc.html) is an optimized compiler collection for C, C++ and Fortran. It generates code optimized for AMD CPUs, in particular for newest Zen4 and Zen5 architectures.

The module name for AOCC compiler bunlde  is __aocc__, as in ```module spider aocc```. The compilers are called __clang__ , __clang++__ and __flang__ .

## MPI and Interconnect libraries
---

The standard distribution of MPI on Grex is [OpenMPI](https://www.open-mpi.org/). We build most of the software with it. To keep compatibility with the old Grex software stack, we name the modules __ompi__. MPI modules depend on the compiler they were built with, which means that a compiler module should be loaded first; then the dependent MPI modules will become available as well. Changing the compiler module will trigger automatic MPI module reload. This is how the Lmod hierarchy works now.

For a long time Grex was using the interconnect drivers with ibverbs packages from the IB hardware vendor, Mellanox. It is no longer the case: for CentOS-7, we have switched to the vanilla Linux InfiniBand drivers, the open source RDMA-core package, and OpenUCX libraries. The current version of UCX on Grex is 1.6.1. Recent versions of OpenMPI (3.1.x and 4.0.x) do support UCX. Also, our OpenMPI is built with process management interface versions PMI1, PMI2 and PMIx4, for tight integration with the SLURM scheduler.

The current default and recommended version of MPI is OpenMPI 4.1. 

{{< highlight bash >}}
#load a compiler module first!
module load openmpi/4.1.6
{{< /highlight >}}

All MPI modules, be that OpenMPI or Intel, will set MPI compiler wrappers such as __mpicc__, __mpicxx__, __mpif90__ to the compiler suite they were built with. The typical workflow for building parallel programs with MPI would be to first load a compiler module, then an MPI module, and then use the wrapper of C, C++ or Fortran in your makefile or build script.

In case a build or configure script does not want to use the wrapper and needs explicit compiler and link options for MPI, OpenMPI wrappers provide the __-\-show__ option that lists the required command line options. Try for example:

{{< highlight bash >}}
mpicc --show
{{< /highlight >}}

to print include and library flags to the C compiler to be linked against the currently loaded OpenMPI version. 

There is also IntelMPI, for which the modules are named __intelmpi__. See the notes on running MPI applications under SLURM [here](/running/batch).

## Linear Algebra BLAS/LAPACK
---

Linear Algebra packages are used in most of the STEM research software. A very popular suite of libraries are BLAS and LAPACK from [NetLib](https://www.netlib.org/), written in Fortran and C.
However, modern CPU architectures with its complex instruction sets and memory hierarchies are too complex for code generation.
Various [optimizations](https://agner.org/optimize/) allow to improve BLAS and LAPACK performance at least tenfold as compared to the reference Netlib versions.
Thus it is always a good idea to use the Linear Algebra libraries that are optimized for a given CPU architecture. Such as vendor-optimized Intel MKL and AMD AOCL, OpenBLAS, or similar. These libraries are provided as modules on HPC systems.

>It is worth noting that the linear algebra libraries might come with two versions: one 32-bit array indexes, another full **64-bit**. Users must pay attention and link against the proper version for their software (that is, a Fortran code with -i8 or -fdefault-integer-8 would link against **64-bit** pointers BLAS).

### Intel MKL
---

The fastest BLAS/LAPACK implementation from Intel, for Intel CPUs. With Intel compilers, it can be used as a convenient compiler flag, __-mkl__ or if threaded version is not needed, __-mkl=sequential__.

With both Intel and GCC compilers, the MKL libraries can be linked explicitly with compiler/linker options. The base path for MKL includes and libraries is defined as the _MKLROOT_ environment variable. For GCC compilers, ```module load mkl``` is needed to add _MKLROOT_ to the environment. There is a command line [advisor](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) Website to pick the correct order and libraries. Libraries with the \_ilp64 suffix are for **64-bit** indexes while \_lp64 are for the default, **32-bit** indexes.

Note that when the milti-threaded MKL is used, the number of threads is controlled with the _MKL_NUM_THREADS_ environment variable. On the Grex software stack, it is set by the MKL module to 1 to prevent accidental CPU oversubscription. Redefine it in your SLURM job scripts if you really need threaded MKL execution as follows:

{{< highlight bash >}}
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK
{{< /highlight >}}

We use the MKL's BLAS and LAPACK for compiling R and Python's NumPY package on Grex, and that's one example when threaded MKL can speed up computations if the code spends significant time in linear algebra routines by using SMP.

MKL distributions also include ScaLAPACK and FFTW libraries.

### OpenBLAS
---

The successor and continuation of the famous GotoBLAS2 library. 
It contains both BLAS and LAPACK in a single library, __libopenblas.a__ . Only the BLAS portion of the library is CPU-optimized though, so performance of LAPACK would lag behind Intel MKL.
Use ''module spider openblas'' to find available versions for a given compiler suite. We provide both **32-bit** and **64-bit** indexes versions (and reflect it in the version names, like _openblas/0.3.7-i32_). The [performance of OpenBLAS](https://software.intel.com/en-us/articles/performance-comparison-of-openblas-and-intel-math-kernel-library-in-r) is close to that of MKL.

OpenBLAS does not contain ScaLAPACK, which would have to be loaded as a separate module.

### AMD AOCL
---

AMD provides its vendor-optimized version of [Blis](https://en.wikipedia.org/wiki/BLIS_(software)) and [FLAME](https://github.com/flame/libflame) libraries which are modern, C++ template based implementations of BLAS and LAPACK. 
Use ''module spider aocl'' to see how to load it. AOCL also includes ScaLAPACK for OpenMPI.

## ScaLAPACK
---
[ScaLAPACK](https://www.netlib.org/scalapack/) is "a library of high-performance linear algebra routines for parallel distributed memory machines."
It is almost always used together with an optimized BLAS/LAPACK implementation. Being a parallel library, ScaLAPACK depends on BLACS, which in turn depends on an MPI library.

Intel MKL includes ScaLAPACK with support of both IntelMPI and OpenMPI for the BLACS layer. MKL also provides ScaLAPACK in both 32bit and 64bit interfaces. It is thus necessary to pick the right library to link against. The [command line advisor](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) is helpful for that.

AMD AOCL includes a single ScaLAPACK library compatible with OpenMPI 4.1.

OpenBLAS does not come with ScaLAPAC and needs the separate module loaded for the later.

## Fast Fourier Transform (FFTW)
---

FFTW3 is the standard and well performing implementation of FFT. ```module spider fftw``` should find it. There is a parallel version of the FFTW3 that depends on MPI it uses, thus to load the _fftw_ module, compiler and MPI modules would have to be loaded first. MKL also provides FFTW bindings, which can be used as follows:

Either Intel or GCC MKL modules would set the _MKLROOT_ environment variable, and add necessary directories to _LD_LIBRARY_PATH_. The _MKLROOT_ is handy when using explicit linking against libraries. It can be useful if you want to select a particular compiler (Intel or GCC), pointer width (the corresponding libraries have suffix _lp64 for **32-bit** pointers and_ilp64 for 64 bit ones; the later is needed for, for example, Fortran codes with INTEGER*8 array indexes, explicit or set by -i8 compiler option) and a kind of MPI library to be used in BLACS (OpenMPI or IntelMPI which both are available on Grex). An example of the linker options to link against sequential, 64 bit pointed version of BLAS, LAPACK for an Intel Fortran code is:

{{< highlight bash >}}
ifort -O2 -i8 main.f -L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm
{{< /highlight >}}

MKL also has FFTW bindings. They have to be enabled separately from the general Intel compilers installation; and therefore, details of the usage might be different between different clusters. On Grex, these libraries are present in two versions: **32-bit** pointers (libfftw3xf_intel_lp64) and **64-bit** pointers (fftw3xf_intel_ilp64). To link against these FFT libraries, the following include and library options to the compilers can be used (for the _lp64 case):

{{< highlight bash >}}
-I$MKLROOT/include/fftw -I$MKLROOT/interfaces/fftw3xf -L$MKLROOT/interfaces/fftw3xf -lfftw3xf_intel_lp64
{{< /highlight >}}

The above line is, admittedly, rather elaborate but gives the benefit of compiling and building all of the code with MKL, without the need for maintaining a separate library such as FFTW3.

AOCL provides an optimized FFTW dynamic library included in the aocl module.

## HDF5 and NetCDF
---

Popular hierarchical data formats. Two versions exist on the Grex software stack, one serial and another MPI-dependent version. Which one you load depends whether MPI is loaded.

To see the available versions, use:

{{< highlight bash >}}
module spider hdf5
{{< /highlight >}}

and/or:

{{< highlight bash >}}
module spider netcdf
{{< /highlight >}}

## Python
---

There are modules for Python versions that we buid from source using optimizations specific to our HPC hardware.
> Note that the base OS python should in most cases not be used; rather find and use a module!

{{< highlight bash >}}
module spider python
{{< /highlight >}}

We do install certain most popular python modules centrally. _pip list_ would show the installed modules.

## R
---

We build R from sources and link against MKL. We find that some packages would only work with GCC-compiled versions of R, so R requires usin one of GCC toolchains.

{{< highlight bash >}}
module spider "r"
{{< /highlight >}}

Several of the most popular R packages are installed with the R modules on Grex. Note that it is often the case that R packages are bindings for some other software (JAGS, GEOS, GSL, PROJ, etc.) and require the software or its dynamic libraries to be available at runtime. This means, the modules for the dependencies (JAGS, GEOS, GSL, PROJ) are also to be loaded when R is loaded.

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Oct 11, 2024.
-->
