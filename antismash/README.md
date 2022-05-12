For CHTC info see: 

- <https://chtc.cs.wisc.edu/uw-research-computing/conda-installation.html>
- <https://chtc.cs.wisc.edu/uw-research-computing/file-avail-largedata.html>

Install conda if needed
```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
```

Create the conda environment for distribution to nodes, using the script: `create_conda_exe.sh `

Check the size of the resulting tar.gz file, e.g. `ls -sh antismash.tar.gz`

antiSMASH 6.1.1 resulted in a 4GB tar.gz (approx. 9GB decompressed) so it has to be placed in `staging`
