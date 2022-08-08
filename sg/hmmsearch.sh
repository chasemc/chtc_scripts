#!/bin/bash

# have job exit if any command returns with non-zero exit status (aka failure)
set -e


a=$1
b=$2
# replace env-name on the right hand side of this line with the name of your conda environment
ENVNAME=sg_conda
# if you need the environment directory to be named something other than the environment name, change this line
ENVDIR=$ENVNAME

# these lines handle setting up the environment; you shouldn't have to modify them
export PATH
mkdir $ENVDIR
tar -xzf $ENVNAME.tar.gz -C $ENVDIR
. $ENVDIR/bin/activate


#  $1 is the hmm profile; gzip file name with no extensions
#  $2 is the protein fasta; gzip file name with no extensions
HMM_INPUT_FILE=$1
FASTA_INPUT_FILE=$2
HMM_BASENAME="${HMM_INPUT_FILE%.hmm.gz}"
FAA_BASENAME="${FASTA_INPUT_FILE%.faa.gz}"

zcat ${FASTA_INPUT_FILE} > input_fasta_file.faa

# Saving new files as "${1}_${2}" only for troubleshooting purposes
# especially for troubleshooting any chtc issues
outfilename="${HMM_BASENAME}-sgout-${FAA_BASENAME}"

# Run hmmsearch
hmmsearch \
    --domtblout "${outfilename}.domtblout" \
    -Z 57096847 \
    -E 100 \
    --cpu 1 \
    --seed 42 \
    ${HMM_INPUT_FILE} \
    input_fasta_file.faa > /dev/null 2>&1
    #-A "${outfilename}.align" \
    #--tblout "${outfilename}.tblout" \


# send files we don't want returned to nope
mkdir nope
mv input_fasta_file.faa nope/input_fasta_file.faa
gzip -6 --rsyncable "${outfilename}.domtblout" 
md5sum "${outfilename}.domtblout.gz" > "${outfilename}.md5"
