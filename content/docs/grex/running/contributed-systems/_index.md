--- 
bookCollapseSection: true
title: "Contributed systems"
---

# Scheduling policies for contributed systems

![]("https://github.com/um-grex/grex-docs/tree/main/static/computerack-back.png")

Grex has a few user contributed nodes. The owners of the hardware have preferred access to them. The current mechanism for the "preferred access" is preemption.

## On the definition of preferential access to HPC systems

Preferential access is when you have a non-exclusive access to your hardware, in a sense that others can share in its usage over large enough periods. There are the following technical possibilities that rely on the HPC batch queueing technology we have. HPC makes access to CPU cores / GPUs / Memory exclusive per job, for the duration of the job (as opposed to time-sharing). Priority is a factor that decides, which job gets to start (and thus exclude other jobs) first if there is a competitive situation (more jobs than free cores).

The owner is the owner of the contributed hardware. Others are other users. A **partition** is a subset of the HPC system’s compute nodes.

Preemption by partition: the contributed nodes have a SLURM partition on them, allowing the owner to use them, normally, for batch or interactive jobs. The partition is a “preemptor”. There is an overlapping partition, on the same set of the nodes but for the others to use, which is “preemptible”. Jobs in the preemptible partition can be killed after a set “grace period” (1 hour) as the owner's job enter the "preemptor" partition. If works, pre-empted jobs might be checkpointed rather than killed, but that’s harder to set up. Currently, it is not generally supported. If you have a code that supports checkpoint/restart at the application level, you can get most of the contributed nodes.

On Grex, the "preemptor" partition is named after the name of the owner PI, and the preemptible partitions named similarly but with added **\-b** suffix. Use the __-\-partition=__ option to submit the jobs with __sbatch__ and __salloc__ commands to select the desired partition.

{{< hint warning >}}
**TODO: this article is a draft; guidelines for contrib systems are being developed.**
{{< /hint >}}

