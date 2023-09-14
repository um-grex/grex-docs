---
weight: 1400
linkTitle: "Code development"
title: "Code Development on Grex"
description: "Everything you need to know about development tools."
categories: ["Software", "Applications"]
#tags: ["Configuration"]
---

## Introduction
---

Grex comes with a sizable software stack that contains most of the software development environment for typical HPC applications. This section of the documentation covers the best practices for compiling and building your own software on Grex.

The login nodes of Grex can be used to compile codes and to run short interactive and/or test runs. All other jobs must be submitted to the [batch](running-jobs/batch-jobs) system. We do not do as heavy resource limiting on Grex login nodes as, for example, Compute Canada does; so, code development on login nodes is entirely possible. However, it might still make sense to perform some of the code development in interactive jobs, in cases such as (but not limited to):

> **(a)** the build process and/or tests requires heavy, many-core computations

> **(b)** you need access to specific hardware not present on the login nodes, such as GPUs and AVX512 CPUs.

Most of the software on Grex is available through environmental modules. To find a software development tool or a library to build your code against, the __module spider__ command is a good start. The applications software is usually installed by us from sources, into subdirectories under __/global/software/cent7__

It is almost always better to use communication libraries (MPI) provided on Grex rather than building your own, because ensuring tight integration of these libraries with our SLURM scheduler and low-level, interconnect-specific libraries might be tricky.

## General CentOS-7 notes
---

The base operating system on Grex is CentOS 7.x that comes with its set of development tools. However, due to the philosophy of CentOS, the tools are usually rather old. For example, __cmake__ and __git__ are ancient versions of 2.8, 1.7 respectively. Therefore, even for these basic tools you more likely want to load a module with newest versions of these tools:

{{< highlight bash >}}
module load git
module load cmake
{{< /highlight >}}

CentOS also has its system versions of Python, Perl, and GCC compilers. When no modules are loaded, the binaries of these will be available in the PATH. The purpose of these is to make some systems scripts possible, to compile OS packages, drivers and so on.

We do not install many packages for the dynamic languages system-wide, because it makes maintaining different versions of them complicated. The same advice applies: use the **module spider** command to find a version of Perl, Python, R, etc. to suit your needs. The same applies to compiler suites like GCC and Intel.

We do install CentOS packages with OS that are:

> * base OS packages necessary for functioning

> * graphical libraries that have many dependencies

> * never change versions that are not critical for performance and/or security. 

> * Here are some examples: FLTK, libjpeg, PCRE, Qt4 and Gtk. Login nodes of Grex have many ''-devel'' packages installed, while compute nodes do not because we want them lean and quickly re-installable. Therefore, compiling codes that requires ''-devel'' base OS packages might fail on compute nodes. Contact us if something like that happens when compiling or running your applications.

Finally, because HPC machines are shared systems and users do not have _sudo_ access, following some instructions from a Web page that asks for _apt-get install this_ or _yum install that_ will fail. Rather, __module spider__ should be used to see if the package you want is already installed and available as a module. If not, you can always contact [support](support) and ask for help to install the program either under your account or as a module when possible. 

## Compilers and Toolchains
---

Due to the hierarchical nature of our **Lmod** modules system, compilers and certain core libraries (MPI and CUDA) form toolchains. Normally, you would need to choose a compiler suite (Intel or GCC) and, in case of parallel applications, a MPI library (OpenMPI or IntelMPI). These come in different versions. Also, you'd want to know if you want CUDA should your applications be able to utilize GPUs. A combination of compiler/version, MPI/version and possibly CUDA makes a toolchain. Toolchains are mutually exclusive; you cannot mix software items compiled with different toolchains!

See Modules for more information.

__There is no module loaded by default__! There will be only the system's GCC-4.8 and no MPI whatsoever. To get started, load a compiler/version. Then, if necessary, an MPI (ompi or impi) and if necessary, CUDA (for which 10.2 is the current version, there is no known reason to use another).

{{< highlight bash >}}
module load intel/2019.5
module load ompi/3.1.4
{{< /highlight >}}

The above loads Intel compilers and OpenMPI 3.1.4. The example below is for GCC 7 and openmpi 4.1.2. 

{{< highlight bash >}}
module load gcc/7.4
module load ompi/4.1.2
{{< /highlight >}}

The MPI wrappers (__mpicc__, __mpicxx__, __mpif90__, ... etc.) will be set correctly by __ompi__ modules to point to the right compiler.

### Intel compilers suite
---

At the moment of writing this documentation, the following Intel Compilers Suites are available on Grex:

  - __Intel 2020.4__ : a recent Intel Parallel Studio suite.
  - __Intel 2019.5__ : a recent Intel Parallel Studio suite. Most software is compiled with it, so use this one if unsure.
  - __Intel 2017.8__ : a somewhat less recent Intel Parallel studio suite.
  - __Intel 15.0__ : Legacy, for maintenance of older Grex software. Do not use it for anything new, unless absolutely must.
  - __Intel 14.1__ : a very old one, for maintenance of older Grex software, and broken. Do not use. It will be removed soon.
  - __Intel 12.1__ : a very old one, for maintenance of a very old PETSc version. Do not use.

The name for the Intel suite modules is __intel__; ```module spider intel``` is the command to find available Intel versions. The latter is left for compatibility with legacy codes. It does not work with systems C++ standard libraries well, so _icpc_ for Intel 12.1 might be dysfunctional. So the intel/12.1 toolchain is actually using GCC 4.8's C++ and C compilers. 

If unsure, or do not have a special reason otherwise, use Intel 15.0 compilers (icc, icpc, ifort). Intel 15.0 is probably the first Intel compiler to support AVX512 if you are going to use the contributed nodes that have AVX512 architecture.

The Intel compilers suite also provides tools and libraries such as [MKL](https://software.intel.com/en-us/mkl) (Linear Algebra, FFT, etc.), Intel Performance Primitives (IPP), Intel [Threads Building Blocks](https://software.intel.com/en-us/tbb) (TBB), and [VTune](https://software.intel.com/en-us/vtune). Intel MPI as well as MKL for GCC compilers are available as separate modules, should they be needed for use separately.

### GCC compilers suite
---

At the moment of writing this page, the following GCC compilers are available:

 - GCC 11.2
 - GCC 9.2
 - GCC 7.4
 - GCC 5.2
 - GCC 4.8

The name for GCC is __gcc__, as in ```module spider gcc```. The GCC 4.8 is a placeholder module; its use is to unload any other modules of the compiler family, to avoid toolchains conflicts. Also, GCC 4.8 is the only multi-lib GCC compiler around; all the others are strictly **64-bit**, and thus unable to compile legacy **32-bit** programs.

For utilizing the AVX512 instructions, probably the best way is to go with the latest GCC compilers (9.2 and 7.4) and and latest MKL. GCC 4.8 does not handle AVX512. Generally Intel compilers outperform GCC, but GCC might have better support for the recent C++11,14,17 standards.

## MPI and Interconnect libraries
---

The standard distribution of MPI on Grex is [OpenMPI](https://www.open-mpi.org/). We build most of the software with it. To keep compatibility with the old Grex software stack, we name the modules __ompi__. MPI modules depend on the compiler they were built with, which means that a compiler module should be loaded first; then the dependent MPI modules will become available as well. Changing the compiler module will trigger automatic MPI module reload. This is how the Lmod hierarchy works now.

For a long time Grex was using the interconnect drivers with ibverbs packages from the IB hardware vendor, Mellanox. It is no longer the case: for CentOS-7, we have switched to the vanilla Linux InfiniBand drivers, the open source RDMA-core package, and OpenUCX libraries. The current version of UCX on Grex is 1.6.1. Recent versions of OpenMPI (3.1.x and 4.0.x) do support UCX. Also, our OpenMPI is built with process management interface versions PMI1, PMIx2 and 3, for tight integration with the SLURM scheduler.

The current default and recommended version of MPI is OpenMPI 4.1.1. OpenMPI 4.1 works well for new codes but could break old ones. There is an older version, OpenMPI 3.1.4 or 3.1.6 that is more compatible. A very old OpenMPI 1.6.5 exists for compatibility with older software. 

{{< highlight bash >}}
module load ompi/3.1.4
{{< /highlight >}}

There is also IntelMPI, for which the modules are named __impi__. See the notes on running MPI applications under SLURM [here](../../running/batch).

All MPI modules, be that OpenMPI or Intel, will set MPI compiler wrappers such as __mpicc__, __mpicxx__, __mpif90__ to the compiler suite they were built with. The typical workflow for building parallel programs with MPI would be to first load a compiler module, then an MPI module, and then use the wrapper of C, C++ or Fortran in your makefile or build script.

In case a build or configure script does not want to use the wrapper and needs explicit compiler and link options for MPI, OpenMPI wrappers provide the __-\-show__ option that lists the required command line options. Try for example:

mpicc --show

to print include and library flags to the C compiler to be linked against the currently loaded OpenMPI version. 

## Linear Algebra BLAS/LAPACK
---

It is always a bad idea to use the reference BLAS/LAPACK/CLAPACK from Netlib (or the generic -lblas, -llapack from CentOS or EPEL which also likely is the reference BLAS/LAPACK from Netlib). The physical Computer architecture has much evolved, and is now way different from the logical Computer the human programmer is presented with. Today, it takes careful, manual assembly coding optimization to implement BLAS/LAPACK that performs fast on modern CPUs with their memory hierarchies, instruction prefetching and speculative execution. A vendor-optimized BLAS/LAPACK implementation should always be used. For the Intel/AMD architectures, it is Intel MKL, OpenBLAS, and BLIS.

Also, it is worth noting that the linear algebra libraries might come with two versions: one 32-bit array indexes, another full **64-bit**. Users must pay attention and link against the proper version for their software (that is, a Fortran code with -i8 or -fdefault-integer-8 would link against **64-bit** pointers BLAS).

### MKL
---

The fastest BLAS/LAPACK implementation from Intel. With Intel compilers, it can be used as a convenient compiler flag, __-mkl__ or if threaded version is not needed, __-mkl=sequential__.

With both Intel and GCC compilers, the MKL libraries can be linked explicitly with compiler/linker options. The base path for MKL includes and libraries is defined as the _MKLROOT_ environment variable. For GCC compilers, ```module load mkl``` is needed to add _MKLROOT_ to the environment. There is a command line [advisor](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) Website to pick the correct order and libraries. Libraries with the \_ilp64 suffix are for **64-bit** indexes while \_lp64 are for the default, **32-bit** indexes.

Note that when Threaded MKL is used, the number of threads is controlled with the _MKL_NUM_THREADS_ environment variable. On the Grex software stack, it is set by the MKL module to 1 to prevent accidental CPU oversubscription. Redefine it in your SLURM job scripts if you really need threaded MKL execution as follows:

{{< highlight bash >}}
export MKL_NUM_THREADS=$SLURM_CPUS_PER_TASK
{{< /highlight >}}

We use the MKL's BLAS and LAPACK for compiling R and Python's NumPY package on Grex, and that's one example when threaded MKL can speed up computations if the code spends significant time in linear algebra routines by using SMP.

Note that MKL also provides ScaLAPACK and FFTW libraries.

### OpenBLAS
---

The successor and continuation of the famous GotoBLAS2 library. It contains both BLAS and LAPACK in a single library, __libopenblas.a__ . Use ''module spider openblas'' to find available versions for a given compiler suite. We provide both **32-bit** and **64-bit** indexes versions (and reflect it in the version names, like _openblas/0.3.7-i32_). The [performance of OpenBLAS](https://software.intel.com/en-us/articles/performance-comparison-of-openblas-and-intel-math-kernel-library-in-r) is close to that of MKL.

### BLIS
---

[Blis](https://en.wikipedia.org/wiki/BLIS_(software)) is a recent, C++ template based implementation of linear algebra that contains a BLAS interface. On Grex, only **32-bit** indexes BLIS is available at the moment. Use ''module spider blis'' to see how to load it.

### ScaLAPACK
---

MKL has ScaLAPACK included. Note that it depends on BLACS which in turn depends on an MPI version. MKL comes with support of OpenMPI and IntelMPI for the BLACS layer; it is necessary to pick the right library of them to link against.

The [command line advisor](https://software.intel.com/en-us/articles/intel-mkl-link-line-advisor) is helpful for that.

## Fast Fourier Transform (FFTW)
---

FFTW3 is the standard and well performing implementation of FFT. ```module spider fftw``` should find it. There is a parallel version of the FFTW3 that depends on MPI it uses, thus to load the _fftw_ module, compiler and MPI modules would have to be loaded first. MKL also provides FFTW bindings, which can be used as follows:

Either Intel or GCC MKL modules would set the _MKLROOT_ environment variable, and add necessary directories to _LD_LIBRARY_PATH_. The _MKLROOT_ is handy when using explicit linking against libraries. It can be useful if you want to select a particular compiler (Intel or GCC), pointer width (the corresponding libraries have suffix _lp64 for **32-bit** pointers and_ilp64 for 64 bit ones; the later is needed for, for example, Fortran codes with INTEGER*8 array indexes, explicit or set by -i8 compiler option) and kind of MPI library to be used in BLACS (OpenMPI or IntelMPI which both are available on Grex). An example of the linker options to link against sequential, 64 bit pointed version of BLAS, LAPACK for an Intel Fortran code is:

{{< highlight bash >}}
ifort -O2 -i8 main.f -L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm
{{< /highlight >}}

MKL also has FFTW bindings. They have to be enabled separately from the general Intel compilers installation; and therefore, details of the usage might be different between different clusters. On Grex, these libraries are present in two versions: **32-bit** pointers (libfftw3xf_intel_lp64) and **64-bit** pointers (fftw3xf_intel_ilp64). To link against these FFT libraries, the following include and library options to the compilers can be used (for the _lp64 case):

{{< highlight bash >}}
-I$MKLROOT/include/fftw -I$MKLROOT/interfaces/fftw3xf -L$MKLROOT/interfaces/fftw3xf -lfftw3xf_intel_lp64
{{< /highlight >}}

The above line is, admittedly, rather elaborate but give the benefit of compiling and building all of the code with MKL, without the need for maintaining a separate library such as FFTW3.

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

There are Conda python modules and Python built from sources with a variety of the compilers. The conda based modules can be distinguished by the module name. Note that the base OS python should in most cases not be used; rather use a module:

{{< highlight bash >}}
module spider python
{{< /highlight >}}

We do install certain most popular python modules (such as Numpy, Scipy, matplotlib) centrally. _pip list_ and _conda list_ would show the installed modules.

## R
---

We build R from sources and link against MKL. There are Intel 15 versions of R; however, we find that some packages would only work with GCC-compiled versions of R because they assume GCC or rely on some C++11 features that the older Intel C++ might be lacking. To find available modules for R, use:

{{< highlight bash >}}
module spider "r"
{{< /highlight >}}

Several R packages are installed with the R modules on Grex. Note that it is often the case that R packages are bindings for some other software (JAGS, GEOS, GSL, PROJ, etc.) and require the software or its dynamic libraries to be available at runtime. This means, the modules for the dependencies (JAGS, GEOS, GSL, PROJ) are also to be loaded when R is loaded.

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* 
*
*
-->
