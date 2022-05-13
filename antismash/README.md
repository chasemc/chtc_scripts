
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

# 2: Transfer to staging

Transfer the created `antismash.tar.gz` to CHTC's staging -> `/staging/groups/kwan_group/antismash.tar.gz`

# 3: Setup run

Login to your account on CHTC's submit server

Transfer `antismash_cmd.sh`, `antismash_main.sh` to the submit node, place in you top directory (e.g. `username@submit2.chtc.wisc.edu:/home/username/antismash_cmd.sh`)

Transfer your genomes to a directory named `genomes`
(e.g. `username@submit2.chtc.wisc.edu:/home/username/genomes/my_genome.gbff.gz`)

Make sure the scripts are executable:

```bash
chmod +x antismash_main.sh
chmod +x antismash_cmd.sh
```

# Create sample list

Create the list of genomes that will be passed 1-per-job

```bash
ls genomes/* > sample_matrix.csv
```
