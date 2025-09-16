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

Some of the mechanisms to handle these dependency problems are:
 *  _conda_ (including everything, most of Linux with all the software binaries in Python repo). 
 * _virtualenv_ / _pip_. 
 * packaging Python modules as HPC software Modules.
 * using Linux containers like Docker or Singularity with all the software packed up by the software developers.

The _conda_ offers an easy way to package up all dependencies and often is liked by the users. Many _conda_ repositories exist. Sometimes _conda_ is the only way to run a particularly badly maintained Python package.
However, it has important drawbacks such as packaging up all the dependencies which uses a lot of disk space, and provide for conflicts with HPC and Linux environments. Thus, _conda_ can be used on HPC machines like Grex at the user's risk.
In particular, we suggest against any automatic "activation" of _conda_ environments in users' startup scripts (like _~/.bashrc_). 

{{< alert type="warning" >}}
Note that as of 2024, Anaconda owners strictened their licensing policy. We do not provide any system-wide _conda_ installations on Grex. In case users want to continue using _conda_, they must be sure that they have a proper Anaconda license to do so. Note also that the same applies for _mamba_ which would use the same conda software channels.
{{< /alert  >}}

The _virtualenv_, while similar to _conda_ in that it would isolate the Python dependencies, is more HPC-friendly because it allows for using HPC modules together with Python _pip_ to control dependencies per particular software item. ComputeCanada / The Alliance has chosen to provide for the CCEnv just basic Python as a Module, and let users use _virtualenv_ for each workflow they would like.
ComputeCanada / The Alliance provides repackaged Python "wheels" to work properly with CCEnv. _pip install_ from CCEnv would use these wheels first. Using _--index-url _ that would point to other sources of the "wheels" can lead to problems and broken installations.

Adding each and every package with pip is time-consuming. CCEnv provides "modules" for a most common combination of fixed module versions of NumPy, SciPy, Matplotlib, etc., so-called _scipy-stack_ modules.
 
## Examples of Use Cases
---

###  Example 1: using OpenAI shape-e in CCEnv virtualenv


Let us put the above into practice, by using an old OpenAI ML model, [shap-e](https://github.com/openai/shap-e) that can generate 3D objects in the form of _.ply_ meshes, from a text.
The example below will use the Alliance software environment, _virtualenv_, and the "shap-e" model fetched from GitHub.

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

If the above commands had passed without the errors, we should be able to use the model. A standalone example (made from the Jupyter notebook provided in the GitHub repo) should be able to run with Python in this _virtualenv and generate the _.ply_ mesh files.

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

It also is possible to start a [Jupyter Notebook](/specific-soft/jupyter-notebook) server while being in the same environment and use the model interactively, with example Notebooks provided under _shap-e/examples_.

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

###  Example 2: using manga-image-translator with Singularity 

Containers are another popular way of managing Python dependencies.  In this example, let us try to translate Manga captions using AI code and models from [manga-image-translator](https://github.com/zyddnys/manga-image-translator) . We will need the software and the AI models it is using. While it is possible to build the software from GitHub sources with pip/virtualenv, it can be tricky and time consuming.
The authors of the repository have provided [a container image on DockerHub](https://hub.docker.com/r/zyddnys/manga-image-translator) . We will be using the image on Grex with Singularity/ Apptainer.
Singularity can pull and run many (but not every of them!) Docker images that are simple enough. Inspection of [the Docker recipe here](https://github.com/zyddnys/manga-image-translator/blob/main/Dockerfile) shows that the image is simple because it does not have any USER command. Moreover, we see that there is an ENTRYPOINT defined:

> ENTRYPOINT ["python", "-m", "manga_translator"]

Knowing the entry point is useful for running the same image with _singularity exec_. Let us first try to download and convert the Docker image into a new Singularity image in the SISF format.

{{< highlight bash >}}
# Lets use singularity to pull the container from DockerHub
module load singularity
singularity pull docker://zyddnys/manga-image-translator:main
{{< /highlight >}}

> The SISF image is large (can be 12 to 15GB). The software will be further downloading a couple of 10s of GBs of the LLM models. To avoid running into disk quota issues, it makes sense to do the work on _/project_ filesystem rather than under _/home_!

To try running the container on a GPU, we would need to run an interactive session on a GPU node.

{{< highlight bash >}}
# Lets get an interactive job on a GPU node using 1 GPU for 2 hours. Note that we'd need more memory for LLama models.
salloc --gpus=1 --partition=stamps-b,agro-b,mcordcpu-b --cpus-per-task=4 --mem=100gb --time=0-2:00
{{< /highlight >}}

There is a documentation on the GitHub site on how to run the models. Naturally it describes how to run it with Docker! But we can understand from it that the code expects two directories with the input and output bind-mounted into the container: /app/source and /app-source-translated. 
Docker is using _-v_ flag to bind-mount "volumes". Singularity is more humble and just bind-mounts directories with _-B_ flag. Most of other Docker flags can be omitted, except for the GPU related flag that has to be replaced with _--nv_ for Singularity). 

Let us not forget what the "entrypoint" was! And what were the options required for the Python code itself as distinct to Sing/Docker options to execute the container.
 
{{< highlight bash >}}
# Create source and source-translated directories 
mkdir source
mkdir source-translated
# The example Comics image for AI to work on, from the Github pages of the manga translator. 
# Please make sure to follow all the applicable Copyrigth laws when using pictures from the Internet.

cd source && wget https://user-images.githubusercontent.com/31543482/232265479-a15c43b5-0f00-489c-9b04-5dfbcd48c432.png 
cd ..

# lets try to run the container, finally
singularity exec   --nv  -B `pwd`/source:/app/source -B `pwd`/source-translated:/app/translated manga-image-translator_main.sif python -m manga_translator --use-gpu -l ENG -i source  -v --translator=sugoi -m batch --overwrite   --manga2eng
{{< /highlight >}}

The command above fails! The error mentions something about a directory "/app/models/translatiors". 
The reason is that unlike Docker, Singularity containers are read-only and cannot download or create any new massive data into the existing image. To work around the issue, we would need one more directory, "/app/models/translators" bind mounted for the LLM models it tries to download. 
Also, adding _--writable-tmpfs_ for ephemeral temporary filesystems is often needed for Python codes in Singularity. 

{{< highlight bash >}}
## the directories and test image should already exist from the above example. Lets add translators and bind-mount it to /app/models!
mkdir translators
singularity exec --writable-tmpfs  --nv -B `pwd`/translators:/app/models/translators -B `pwd`/source:/app/source -B `pwd`/source-translated:/app/translated manga-image-translator_main.sif python -m manga_translator --use-gpu -l ENG -i source  -v --translator=sugoi -m batch --overwrite   --manga2eng
{{< /highlight >}}

When the command finishes, the _./source-translated_ would contain a image with Japanese text translated to English.

###  Example 3: using manga-image-translator with Podman 

Singularity is the preferred container engine on our shared HPC systems. However, there are cases when Singularity/Apptainer SISF images would not run Docker images correctly.
In these cases, root-less Podman can be used. Both the Alliance's _CCEnv_ and Grex's _SBEnv_ provide a module for Podman. Using Podman is very similar to using Docker in that Podman supports same command line options.
However, use of Podman in cases when Singularity fails is also more advanced and it would need additional options for user namespace and user/group ID mappings. In general, our support of Podman is as of now considered experimental.

In our example, we would not need these advanced namespaces options because the _manga-image_translator_ is well built to work in either Singularity or Docker. 

To try running the container on a GPU, we would need to run an interactive session on a GPU node.

{{< highlight bash >}}
# Lets get an interactive job on a GPU node using 1 GPU for 2 hours. Note that we'd need more memory for LLama models.
salloc --gpus=1 --partition=stamps-b,agro-b,mcordcpu-b --cpus-per-task=4 --mem=100gb --time=0-2:00
{{< /highlight >}}

Then, we would do exactly the same sequence of commands but with Podman instead of Singularity.

{{< highlight bash >}}
# Lets use podman
module load podman
# directories to bind-mount
mkdir source
mkdir source-translated
# The example Comics image for AI to work on, from the Github pages of the manga translator. 
# Please make sure to follow all the applicable Copyrigth laws when using pictures from the Internet!
cd source && wget https://user-images.githubusercontent.com/31543482/232265479-a15c43b5-0f00-489c-9b04-5dfbcd48c432.png 
cd ..
mkdir translators
# running it with podman. Note the more options like --rm, and how the GPU is handled with --device.
podman run --rm --device=nvidia.com/gpu=all --ipc=host -v `pwd`/translators:/app/models/translators -v `pwd`/source:/app/source -v `pwd`/source-translated:/app/translated docker://zyddnys/manga-image-translator:main --use-gpu -l ENG -i source  -v --translator=sugoi -m batch --overwrite  --manga2eng
{{< /highlight >}}

> Note that the Podman example also bind-mounts the _./translators_ . Even thought it might work without it, it does make a lot of sense to bind-mount ./translators to avoid re-downloading the LLM models into Docker containers' image every time we run a new container instance using them!

## External links
---

* The Alliance documentation about [Python](https://docs.alliancecan.ca/wiki/Python)
* The Alliance list of [Available wheels](https://docs.alliancecan.ca/wiki/Available_Python_wheels)
* An old talk by Bart Oldeman at CC/DRAC [Python at ComputeCanada](https://indico.cism.ucl.ac.be/event/4/contributions/33/attachments/33/65/Python_at_Compute_Canada1.pdf)

### Training Huggingface LLMs on Alliance systems

A new documentation item covers on how to download and use [HuggingFace models on Alliance Software stack](https://docs.alliancecan.ca/wiki/Huggingface#Training_Large_Language_Models_\(LLMs\)).
This documentation largely applies to Grex  as well, when using CCEnv software stack.

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 12, 2024.
-->
