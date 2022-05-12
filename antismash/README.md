
# Conda installation

For CHTC info see: <https://chtc.cs.wisc.edu/uw-research-computing/conda-installation.html>

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
```

```bash
conda create -n antismash antismash==6.1.0 -y
conda activate antismash
download-antismash-databases
conda deactivate
```

```bash
conda install -c conda-forge conda-pack -y
conda pack -n antismash 
chmod 644 antismash.tar.gz
ls -sh antismash.tar.gz
```

