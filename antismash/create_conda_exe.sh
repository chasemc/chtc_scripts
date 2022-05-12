#!/bin/bash

conda create -n antismash antismash==6.1.0 -y
conda activate antismash
download-antismash-databases
conda deactivate

conda install -c conda-forge conda-pack -y
conda pack -n antismash 
chmod 644 antismash.tar.gz
ls -sh antismash.tar.gz
