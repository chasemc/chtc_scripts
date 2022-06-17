#!/bin/bash

# have job exit if any command returns with non-zero exit status (aka failure)
set -e

#  $1 is the hmm profile; gzip file name with no extensions
#  $2 is the protein fasta; gzip file name with no extensions
HMM_INPUT_FILE=$1
FASTA_INPUT_FILE=$2
HMM_BASENAME=$(echo "$HMM_INPUT_FILE" | sed -e "s/.hmm.gz$//")
FAA_BASENAME=$(echo "$FASTA_INPUT_FILE" | sed -e "s/.faa.gz$//")

ENVNAME=sg_conda
ENVDIR=$ENVNAME
export PATH
mkdir $ENVDIR
tar -xzf $ENVNAME.tar.gz -C $ENVDIR
. $ENVDIR/bin/activate



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
    input_fasta_file.faa 
    #-A "${outfilename}.align" \
    #--tblout "${outfilename}.tblout" \

md5sum "${outfilename}.domtblout" > "${outfilename}.md5"
#md5sum "${outfilename}.tblout" >> "${outfilename}.md5"
#md5sum "${outfilename}.align" >> "${outfilename}.md5"

# Compress the domtblout and alignment files,
# use zstd and not gzip because faster and smaller for chtc
gzip -6 --rsyncable  -9 --rm "${outfilename}.domtblout"
#zstd -9 --rm "${outfilename}.tblout"
#zstd -9 --rm "${outfilename}.align"

# Now we create a tar of the files to transfer back on CHTC
# Unnecessary for non-chtc but keeping so that, for now, the
# python script that processes reusults can stay the same between
# the two execution environments
#tar -cvf "results_${outfilename}.tar" "${outfilename}.domtblout.zst" "${outfilename}.tblout.zst" "${outfilename}.align.zst" "${outfilename}.md5" --remove-files
tar -cvf "${outfilename}.tar" "${outfilename}.domtblout.gz" "${outfilename}.md5" --remove-files

# If on CHTC, move results to top dir so it will be sent back
mv ${outfilename}.tar ../${outfilename}.tar

