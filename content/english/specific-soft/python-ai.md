---
weight: 1220
linkTitle: "Python for ML"
title: "Using Python for ML on Grex"
description: "Tips on using Python on Grex for ML and other computations."
categories: ["Software", "Applications", "ML"]
banner: true
bannerContent: "__Work in progress.__"
#tags: ["Configuration"]
---


## Introduction
---

Python is a dynamic language with many optional Library "modules" available. Moreover, Python is often used as a "glue" language for interacting with tools and libraries written in other languages (C/C++, Fortran, CUDA, etc.).
This makes maintenance of Python software difficult. Not only do Python and libraries need to be of the right versions, but also other software they depend on should be of the same versions that have been used to build the corresponding packages.

Some of the mechanisms to handle thiese dependency problems are
 *  _conda_ (including everything, most of Linux with all the software binaries in Python repo). 
 * _virtualenv_ / _pip_ 
 * packaging Python modules as HPC software Modules 

The _conda_ offers an easy way to package up all of the dependencies and often is liked by the users. Many _conda_ repositories exist. Sometimes _conda_ is the only way to run a particularly badly maintained Python package.
However, it has important drawbacks such as packaging up all the dependencies which uses a lot of disk space, and provide for conflicts with HPC and Linux environments. Thus, _conda_ can be used on HPC machines like Grex at the user's risk.
In particular, we suggest against any automatic "activation" of _conda_ environments in users' startup scripts (like _~/.bashrc_).

The _virtualenv_ while similar to _conda_ in that it would isolate the Python dependencies, is more HPC-friendly because it allows for using HPC modules together with Python _pip_ to control dependencies per particular software item. ComputeCanada / The Alliance has chosen to provide for the CCEnv just basic Python as a Module, and let users use _virtualenv_ for each workflow they would like.
ComputeCanada / The Alliance provides repackaged Python "wheels" to work properly with CCEnv. _pip install_ from CCEnv would use these wheels first. Using _--index-url _ that would point to other sources of the "wheels" can lead to problems and broken installations.

Adding each and every package with pip is time-consuming. CCEnv provides "modules" for a most common combination of fixed module versions of NumPy, SciPy, Matplotlib, etc., so-called _scipy-stack_ modules.
 
## An Example: using OpenAI shape-e in CCEnv virtualenv


Let us put the above into practice, by using an old OpenAI ML model, [shap-e](https://github.com/openai/shap-e) that can generate 3D objects in the form of _.ply_ meshes, from a text.
The example below will use the Alliance software environment, _virtualenv_, and the "shap-e" model fetched from Github.

{{< highlight bash >}}
# Lets get an interactive job on a GPU node using 1 GPU for 2 hours
salloc --gpus=1 --partition=stamps-b,agro-b,mcordcpu-b --cpus-per-task=2 --mem=32gb --time=0-2:00
{{< /highlight >}}

> Note the prompt changed to user@gXYZ; you should be on a compute node with GPU now. You can try _nvidia-smi_ command to see the GPU model, driver version etc.

{{< highlight bash >}}
# Let's switch to CCEnv 2023 enviroment  by loading required modules!
module load CCEnv
module load arch/avx512 StdEnv/2023
# Let's load CUDA, cuDNN, python  and Scipy stack modules needed to run the model. 
#The module versions are current as of Jul 2024
module load cuda/12.2 cudnn/9.2.1.18
module load python/3.11.5 scipy-stack/2024a 
which python
{{< /highlight >}}

We now have a *python* executable in the PATH, ready to set up a _virtualenv_ with all the dependencies required by "shap-e". These are Torch, Torchaudio, Torchvision, and PyTorch3d.
It is often a challenge to provide matching versions for these ML libraries, so some trial and error with the "wheels" of the same or close enough versions available on CCEnv is usually required.

{{< highlight bash >}}
# Lets start a virtualenv called shapee
virtualenv shapee
source shapee/bin/activate
{{< /highlight >}}

>  Note the prompt changes again to something like "(shapee) \[user@gXYZ\]". We are now in a new Python environment and can proceed with installing Python dependencies and the ML model using pip.

{{< highlight bash >}}
# These versions work in 2024
pip install jupyter nbconvert jupyter_contrib_nbextensions
pip install torchvision==0.16.2 torchaudio==2.1.1 pytorch3d==0.7.5
git clone https://github.com/openai/shap-e && cd shap-e && pip install -e .
cd ..
{{< /highlight >}}

If the above commands had passed without the errors, we should be able to use the model. A standalone example (made from the Jupyter notebook provided in the Github repo) should be able to run with Python in this _virtualenv and generate the .ply mesh files.

{{< collapsible title="Python script example for shap-e" >}}
{{< snippet
    file="scripts/python/shap-e-test.py"
    caption="shap-e-test.py"
    codelang="python"
/>}}
{{< /collapsible >}}

{{< highlight bash >}}
python shap-e-test.py
{{< /highlight >}}

It also is possible to start a [Jupyter Notebook](/software/jupyter-notebook) server while being in the same environment and use the model interactively, with example Notebooks provided under _shap-e/examples_.

The above scenario is done using interactive _salloc_ job on a GPU node. Interactive sessions are very useful for initializing Python environments and troubleshooting.

For long-running tasks, it is best to run the ML workloads under SLURM batch mode. The same modules must be loaded inside the SLURM job script, and the same _virtualenv_ must be "activated" inside the job script as well, before running Python.
An example job script for running the same Python code as a batch job:

{{< collapsible title="SLURM job script to run the above shap-e Python example" >}}
{{< snippet
    file="scripts/jobs/python-ml/run-python-gpu.sh"
    caption="run-python-gpu.sh"
    codelang="bash"
/>}}
{{< /collapsible >}}

The script can be submitted as usual, with the sbatch command:

{{< highlight bash >}}
sbatch run-python-gpu.sh
{{< /highlight >}}



## External links
---

* The Alliance documentation about [Python](https://docs.alliancecan.ca/wiki/Python)
* The Alliance list of [Available wheels](https://docs.alliancecan.ca/wiki/Available_Python_wheels)
* An old talk by Bart Oldeman at CC/DRAC [Python at ComputeCanada](https://indico.cism.ucl.ac.be/event/4/contributions/33/attachments/33/65/Python_at_Compute_Canada1.pdf)

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 12, 2024.
-->
