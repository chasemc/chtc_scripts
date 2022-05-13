#!/bin/bash

# have job exit if any command returns with non-zero exit status (aka failure)
set -e

# replace env-name on the right hand side of this line with the name of your conda environment
ENVNAME=antismash
# if you need the environment directory to be named something other than the environment name, change this line
ENVDIR=$ENVNAME

#
# First, copy the compressed tar file from /staging into the working directory,
#  and un-tar it to reveal your large input file(s) or directories:
cp /staging/groups/kwan_group/antismash.tar.gz ./

export PATH
mkdir $ENVDIR
tar -xzf antismash.tar.gz -C $ENVDIR
. $ENVDIR/bin/activate

rm antismash.tar.gz

./antismash_cmd.sh \
    "${1}" \
    --cpus 1 \
    --genefinding-tool none \
    --output-dir antismash_results

cd antismash_results

tar -czvf "${1%.tar.gz}".tar.gz *region**.gbk 

cd ..

mv ./antismash_results/"${1%.tar.gz}".tar.gz "${1%.tar.gz}".tar.gz

# Before the script exits, make sure to remove the file(s) from the working directory
rm -rf antismash

#
# END
