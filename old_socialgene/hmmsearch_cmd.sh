#!/bin/bash

# have job exit if any command returns with non-zero exit status (aka failure)
set -e

# replace env-name on the right hand side of this line with the name of your conda environment
ENVNAME=sg-env
# if you need the environment directory to be named something other than the environment name, change this line
ENVDIR=$ENVNAME
 
# these lines handle setting up the environment; you shouldn't have to modify them
export PATH
mkdir $ENVDIR
tar -xzf $ENVNAME.tar.gz -C $ENVDIR
. $ENVDIR/bin/activate
### end of boilerplate
### start of script

# to prevent transferring back unwanted files 
# we'll do all the work in a subdirectory "work"
mkdir work

# move the hmm and fasta files into the "work" directory
mv $1.hmm.gz work/$1.hmm.gz
mv $2.zst work/$2.zst
# move into the "work" directory
cd work
# decompress the input files
gunzip "${1}.hmm.gz"
zstd -d --rm "${2}.zst"

outfilename="${1}_${2}"

# Run hmmsearch
hmmsearch \
    --domtblout "${outfilename}.domtblout" \
    --tblout "${outfilename}.tblout" \
    -A "${outfilename}.align" \
    -Z 57096847 \
    -E 100000 \
    --cpu 1 \
    --seed 42 \
    "${1}.hmm" \
    "${2}" > /dev/null 2>&1

# Compress the domtblout and alignment files

md5sum "${outfilename}.domtblout" > "${outfilename}.md5"
md5sum "${outfilename}.tblout" >> "${outfilename}.md5"
md5sum "${outfilename}.align" >> "${outfilename}.md5"

zstd -9 "${outfilename}.domtblout"
zstd -9 "${outfilename}.tblout" 
zstd -9 "${outfilename}.align"

mkdir results

# Save by moving to top directory (out of "work")
mv "${outfilename}.domtblout.zst" results/"${outfilename}.domtblout.zst"
mv "${outfilename}.tblout.zst" results/"${outfilename}.tblout.zst"
mv "${outfilename}.align.zst" results/"${outfilename}.align.zst"
mv "${outfilename}.md5" results/"${outfilename}.md5"

tar cf results_${outfilename}.tar results/
mv results_${outfilename}.tar ../results_${outfilename}.tar
