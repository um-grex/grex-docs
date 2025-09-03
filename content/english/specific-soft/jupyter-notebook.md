---
weight: 1000
linkTitle: "Jupyter notebooks"
title: "How to use Jupyter notebooks on Grex?"
description: "Everything you need to know for using Jupyter notebooks."
categories: ["Software"]
#tags: ["Configuration"]
---

# Jupyter on Grex
---

[Jupyter](https://jupyter.org/) is a Web-interface aimed to support interactive data science and scientific computing. Jupyter supports several dynamic languages, most notably Python, R and Julia. Jupyter offers a metaphor of "computational document" that combines code, data and visualizations, and can be published or shared with collaborators.

Jupyter can be used either as a simple, individual notebook or as a multi-user Web server/Interactive Development Environment (IDE), such as JupyterHub/JupyterLab. The JupyterHub servers can use a variety of computational back-end configurations: from free-for-all shared workstation to job spawning interfaces to HPC schedulers like SLURM or container workflow systems like Kubernetes.

This page lists examples of several ways of accessing Jupyter notebooks.

## Using notebooks via Grex OOD Web Portal
---

Grex provides Jupyter Notebooks and/or JupyterLab as an [OpenOnDemand](ood) dashboard application. 
This is much more convenient than handling SSH tunnels for Jupyter manually. 
The servers will run as a batch job on Grex compute nodes, so as usual, a choice of SLURM partition will be needed. 

Grex provides access to Jupyter Notebooks and JupyterLab through an [OpenOnDemand](/ood) server Application. This method is much more convenient than manually handling SSH tunnels for Jupyter.

Notebooks under OOD would run as batch jobs on Grex compute nodes, and thus have access to any available hardware such as GPUs, as needed. You will need to select a SLURM partition, as well as other resource requests (CPU, GPU, time) when launching a OOD Jupyter session.

There are multiple versions of the OOD Jupyter application, that correspond to either local Grex software environment (SBEnv) or the Alliance/ComputeCanada environment (CCEnv, using the current StdEnv version). 

<!-- GAS commented out the old pic 
{{< collapsible title="OpenOndemand applications: jupyter" >}}
![](/ood/applications.png)
{{< /collapsible >}}

-->
You can find more information on using OOD in the [Grex OOD documentation pages](/ood) .

## Installing additional Jupyter Kernels

To run, a Jupyter notebook require a connection to a language "kernel". Generally, Jupyter would start only with a Python kernel that came with the jupyter-notebook server. However, there are many more kernels that are available! 

To use R, Julia, or different instances or versions of Python from Jupyter, you must install a corresponding Jupyter Notebook kernel for each language. Each user must install these kernels individually, within their $HOME directories.

> Note that language kernels must match the software environments they will be used with. For example, install kernels using the local Grex software stack if you plan to use them from the Grex OOD Jupyter App. Python's _virtualenv_ can be helful in isolating the various environements and their dependencies.

The kernels are installed under a hidden directory _$HOME/.local/share/jupyter/kernels_. 

### Adding an R kernel
For example, in order to add an R kernel, the following commands can be used:

{{< highlight bash >}}
#Loading the R module of a required version and its dependencies go here. _R_ will be in the PATH.
R -e "install.packages(c('crayon', 'pbdZMQ', 'devtools'), repos='http://cran.us.r-project.org')"
R -e "devtools::install_github(paste0('IRkernel/', c('repr', 'IRdisplay', 'IRkernel')))"
R -e "IRkernel::installspec()"
{{< /highlight >}}

### Adding a Julia kernel
For Julia, the package [IJulia](https://github.com/JuliaLang/IJulia.jl) has to be installed:
{{< highlight bash >}}
#Loading the Python and Jula module of a required version and its dependencies go here. _julia_ will be in the PATH.
echo 'Pkg.add("IJulia")' | julia
python -m ipykernel install --user --name julia --display-name "Julia"
{{< /highlight >}}

### Adding a Python kernel using virtualenv

Users' own Python kernels can be added to Jupyter by using "ipykernel" command. Because there are numerous versions of Pythons across more than one software stack, and Python modules may depend on a variety of other software (such as CUDA or Boost libraries) is usually a good idea to encapsulate the kernel together with all the Python modules required, in a _virtualenv_ . 

The example below creates a virtualenv for using Arrow and Torch libraries in Jupyter, using the Alliance's CCEnv softwre stack. Note that using CUDA from CCEnv requires this to be done on a GPU node, using a __salloc__ interactive job.

{{< highlight bash >}}
# first load all the required modules. The CCEnv stack itself:
module load CCEnv
module load arch/avx2
module load StdEnv/2023
# then Python Arrow with dependendencies. Scipy-Stack provides most common libraries such as NumPy and SciPy.
module load cuda python scipy-stack
module load arrow boost r 

# now we can create a virtualenv, install required modules off CCENv wheelhouse
virtualenv ccarrow
source ccarrow/bin/activate
pip install --upgrade pip
pip install transformers
pip install datasets
pip install evaluate
pip install torch
pip install scikit-learn
pip install ipykernel
pip install jupyter
# finally, register the virtualenv for the current user
python -m ipykernel install --user --name=ccarrow
#check the kernels and flush them changes just to be sure; deactivate the nevironment
jupyter kernelspec list
sync
deactivate
# now, JupyterLab should show a Python kernel named "ccarrow" in the Launcher
{{< /highlight >}}

To be able to actually start the kernel on a JupyerLab notebook webpage, all the modules (cuda python scipy-stack arrow boost r) must be first loaded. One way of loading the modules is to use the Alliance's "Software Module" extension, which is available on the left "tab" of the Jypyter instances that are using CCEnv. 

### Keeping track of installed kernels

The kernels are installed under a hidden directory _$HOME/.local/share/jupyter/kernels_. To list installed kernels, manipulate them etc., there are a few useful commands:

{{< highlight bash >}}
#Loading the Python module of a required version and its dependencies go here. 
jupyter kernelspec list
{{< /highlight >}}
The output will be the list of installed kernels. A kernel can be uninstalled using the following command, referring to a kernel name from the list:
{{< highlight bash >}}
#Loading the Python module of a required version and its dependencies go here. 
jupyter kernelspec  uninstall my_kernel
{{< /highlight >}}


Check out the corresponding Compute Canada documentation [here](https://docs.alliancecan.ca/wiki/JupyterNotebook#Adding_kernels) for more information

## Using notebooks via SSH tunnel and interactive jobs
---

Any Python installation with Jupyter Notebooks installed can be used to launch the simple notebook interface. Since activity on HPC login nodes is usually restricted, you should first start an interactive batch job. Within the interactive session, you will start a Jupyter Notebook server and use an SSH tunnel to connect to it from your local web browser.

After logging on to Grex as usual, issue the following __salloc__ command to start an [interactive job](running-jobs/interactive-jobs):

{{< highlight bash >}}
salloc --partition=skylake --nodes=1 --ntasks-per-node=2 --time=0-3:00:00
{{< /highlight >}}

This should give you a command prompt on a compute node. You may adjust parameters like partition, time limit, etc., to fit your needs.
Next, ensure that a Python module is loaded and that Jupyter is installed, either within the Python environment or a virtual environment. Then start a notebook server, choosing an arbitrary port number, such as 8765. (If the port is already in use, simply pick another.)

> Note that a desired Python module must be loaded, and corresponding virtualenv must be activated as before accessing the jupyter-notebook command!

{{< highlight bash >}}
jupyter-notebook --ip 0.0.0.0 --no-browser --port 8765
{{< /highlight >}}

If successful, there should be at least two lines close to the end of the console output:

 * _http://g333:8765/?token=ae348acfa68edec1001bcef58c9abb402e5c7dd2d8c0a0c9_ 
 * _http://127.0.0.1:8765/?token=ae348acfa68edec1001bcef58c9abb402e5c7dd2d8c0a0c9_

or similar, where g333 refers to a compute node it runs, 8765 is a local TCP port and the token (the long hash code) is an access/authentication browser token. 

At this point, you have a Jupyter Notebook server running on the compute node — but it is not yet accessible from your local browser. To access it, you will need to create an SSH tunnel.

Assumingi you are using a command-line SSH client (OpenSSH or MobaXterm terminal window), opeen a new tab or  terminal and run the following command:

{{< highlight bash >}}
ssh -fNL 8765:g333:8765 yourusername@bison.hpc.umanitoba.ca
{{< /highlight >}}
 
Replace _g333_, _8765_, and _yourusername_ with the correct node name, port, and username.

If successful, the SSH command above returns nothing. Keep the terminal window open for as long as you need the SSH tunnel (that is, for the duration of your Jupyter session).

> Note that only one _port_ can be used per server at a time! If the _port_ you selected is already in use  (due to another Jupyter Notebook session or an existing SSH tunnel), simply pick a different random port (e.g., 8711) and repeat the procedure.

The final step is to open a browser on your client computer (Firefox is the best as Chrome might refuse to do plain http://) and navigate it to the tunnelded _port_ on _localhost_ or **127.0.0.1**, as in _http://localhost:8765_ or _http://127.0.0.1:8765_ . Use the _token_ as per above to authenticate into the jupyter notebook session, either copying it into the prompt or providing it in the browser address line. 

> Simply copying and pasting the Jupyter URL starting from _http://127.0.0.1:8765/?token=your-token-goes-here_ should work! Do not use the URL that starts with the node name (e.g., g333) — it will not work from your local machine.

After this, you should be able to use a Jupyter Notebook, on the compute node, through your local browser. 

The notebook session will remain active as long as:
 * the interactive job (salloc) session is alive,
 * the Jupyter Notebook server is running, and
 * the SSH tunnel remains open.

This method works not only on Grex, but also on the Alliance and most other HPC systems.


## Not using Jupyter notebooks in SLURM jobs

> While Jupyter is a great debugging and visualization tool, for heavy production calculations it is almost always a better idea to use batch jobs. However, the Notebooks cannot be executed from Python (or other script languages) directly!

Fortunately, it is possible to convert Jupyter Notebooks (_.ipynb_ format) to a runnable script using Jupyter's _nbconvert_ command. 

For example, in a Python's Notebook cell:

>!pip install --no-index nbconvert

>!jupyter nbconvert --to script my_notebook.ipynb

Or, in the Jupyter Notebook or JupyterLab GUI, there is an

Or, in command line (provided corresponding Python and Jupyter modules are loaded first):
{{< highlight bash >}}
#Python modules, virtualenv activation commands etc. go here
jupyter nbconvert --to script my_notebook.ipynb
{{< /highlight >}}

Then, in a SLURM job, the resulting script can be executed with a regular Python (or R, or Julia). Again, after loading the required modules,

{{< highlight bash >}}
#SLURM headers and modules go here
python  my_notebook.py
{{< /highlight >}}


## Other jupyter instances around
---

There is a SyZyGy instance [umanitoba.syzygy.ca](https://umanitoba.syzygy.ca) that gives a free-for-all shared SyZyGy JupyterHub for UManitoba users.

Most of the Alliance's  HPC machines deployed [JupyterHub](https://docs.alliancecan.ca/wiki/JupyterHub/en) interfaces, like Narval and Rorqual. These instances submit Jupyter notebooks as SLURM jobs directly from the JupyterHub interface. 

<!-- {{< treeview display="tree" />}} -->

<!-- Changes and update:
* Last reviewed on: Jul 10, 2024 by GAS
-->
