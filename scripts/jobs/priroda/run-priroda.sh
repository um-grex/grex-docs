#!/bin/bash

#SBATCH --nodes=1 
#SBATCH --ntasks-per-node=6
#SBATCH --mem-per-cpu=2000M
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
