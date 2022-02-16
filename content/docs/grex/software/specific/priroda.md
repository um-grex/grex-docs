# Priroda

## Introduction

Priroda is a fast parallel relativistic DFT and ab initio code for molecular modeling, developed by Dr. Dimitri N. Laikov. The code originally implemented fast resolution-of-identity GGA DFT for coulomb and exchange integrals. Later it was extended to provide RI-DFT with hybrid functionals, RI-HF and RI-MP2, and parallel high-level coupled-cluster methods. All these levels of theory can be used together with an efficient all-electron scalar-relativistic method, with small-component bases supplied for all the elements of Periodic Table. The current release of the code also includes a novel NDO-based semiempirical method.

## User Responsibilities and Access

The code is free for academic users, but is not open source. It is distributed on request by the Author, Dr. Dimitri N. Laikov.
To access the Priroda code on Grex, the prospective users have to send us (support@computecanada.ca) a free-form email confirming that 
they have read and agreed to abide by the following conditions:

**Conditions for the Priroda code access on Grex:**

{{< hint danger >}}
* I understand that the Priroda code's ownership and copyright belongs solely to its Author, Dr. Dimitri N. Laikov. I will not incorporate any part of the Priroda code into any other program system, either for sale or for non-profit distribution, without written permission by the Author.
* I will not copy, distribute or supply the Priroda code for any reason whatsoever to third persons or organizations. Instead, I will direct all the code requests to the Author.
 - If results obtained with the code are published, I will cite the proper Priroda code references and, when appropriate, the specific methods references, as described in the Priroda code documentation and/or [Dr.Laikov's website](http://rad.chem.msu.ru/~laikov/).
* I understand that the Priroda code is provided "as is" and the author is not assuming any responsibilities or any liabilities that might arise from the usage of the code, whatsoever.
{{< /hint >}}

After receiving the email, we will add the user to the wg-prrda UNIX group that is used to control access to the Priroda program, basis sets and docummentaton

## Running Priroda on Grex

The Priroda code is linked against OpenMPI bulit with a GCC compiler. There are several versions of them, and _module spider priroda_ would help to locate the dependencies. As of the time of writing, the following command would load the Priroda version of 2016:

{{< hint info >}}
```module load gcc/5.2 ompi/3.1.4 priroda/2016```
{{< /hint >}}

The parallel Priroda executable (called __p__) will be in the PATH after loading of the module. Its basis sets and/or semiempirical method parameters can be found under __$PRIRODA/bin__. Documentation and examples are are available under __$PRIRODA/doc__ and __$PRIRODA/example__, correspondingly. 

The style of the Priroda input is of free format namelist groups, similar to that of GAMESS-US but more flexible (no limitations inherited from Fortran77). Examples and desctiption of each input group are in the __doc__ and __example__ directories.
To invoke the code interactively:

{{< hint info >}}
```mpiexec p name.inp name.out```
{{< /hint >}}

An archive of old Priroda documentation is here [Priroda old docs from KNC](/doc/Priroda_Documentation_from_KNCWiki.pdf)

## Using Priroda with SLURM

Priroda is MPI-parallelized. The parallel efficiency varies on the method used and the kind of calculation (energies, geometry optimizations or analytical hessians) performed. Pure GGA DFT calculations are quite fast and tightly coupled, and makes sense to use single node with a few tasks per node, or a few nodes, as in example below. RI-MP2 calculations would benefit from more massively parallel calculations, spanning several nodes. 

It makes no sense to ask more than 4000mb per task. 

### Sample SLURM Script

{{< hint slurm >}}
{{< highlight bash >}}
#!/bin/bash
#SBATCH --nodes=1 --ntasks-per-node=6 --mem-per-cpu=2000mb
#SBATCH --time=0-2:00:00
#SBATCH --job-name=priroda-test-c60
SCR=$TMPDIR
echo "assuming inputs in $SLURM_SUBMIT_DIR"
module load gcc/5.2 ompi/3.1.4 priroda/2016
# copy the input file (c60.inp) locally and set the resource requests
# and temporary paths. note that the file myfile.inp
# should not have a $system .. $end group
cp c60.inp $SCR/priroda.inp
cd $SCR
echo '   ' >> priroda.inp
echo ' $system ' >> priroda.inp
echo "   memory=1000 disk=10 path=. " >> priroda.inp
echo ' $end ' >> priroda.inp
cat priroda.inp
# Copy basis sets locally:
cp $PRIRODA/bin/*.in $SCR
cp $PRIRODA/bin/*.bas $SCR
echo "Start date:`date`"
# Actually run the job
srun $PRIRODA/bin/p priroda.inp $SLURM_SUBMIT_DIR/c60.$SLURM_JOBID.log
echo "Program finished with exit code $? at: `date`"
{{< / highlight >}}
{{< /hint >}}

## Various scripts and utilities

There are some simple scripts and utilities in __$PRIRODA/contrib__ directory. They can be used for conversions of inputs/outputs to and from Molden XYZ format, extraction of the MOs and vibrational frequencies, and restart informations from the Priroda output files.

