
# 1: Create the conda environment to use in each node

For CHTC info see:

- <https://chtc.cs.wisc.edu/uw-research-computing/conda-installation.html>
- <https://chtc.cs.wisc.edu/uw-research-computing/file-avail-largedata.html>

Install conda if needed

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
```


Install antismash and create a transferable environment using the commands in `create_conda_exe.sh`

> Note: If building on CHTC: the final conda env is ~9 GB before compression and the final file is approximately 4 GB compressed.

# 2: Transfer to staging

Transfer the created `antismash.tar.gz` to CHTC's staging -> `/staging/groups/kwan_group/antismash.tar.gz`

If needed, change the staging path in `antismash_main.sh` (here: <https://github.com/chasemc/chtc_scripts/blob/d75c3c84d4118c73092f3c207650fdc57795bfec/antismash/antismash_main.sh#L14>)

# 3: Setup run

Login to your account on CHTC's submit server

Transfer `antismash_cmd.sh`, `antismash_main.sh`, `chtc_antismash.sub` to the submit node, place in your top directory (e.g. `username@submit2.chtc.wisc.edu:/home/username/antismash_cmd.sh`)

Transfer your genomes to a directory named `genomes`
(e.g. `username@submit2.chtc.wisc.edu:/home/username/genomes/my_genome.gbff.gz`)

Make sure the scripts are executable:

```bash
chmod +x antismash_main.sh
chmod +x antismash_cmd.sh
```

# 4: Create sample list

Create the list of genomes that will be passed 1-per-job

```bash
ls genomes/* > sample_matrix.csv
```

Check your sample list: `less sample_matrix.csv`

# 5: Submit Job

**Important:** For your first submission, just try with one or two genomes.

`condor_submit chtc_antismash.sub`
