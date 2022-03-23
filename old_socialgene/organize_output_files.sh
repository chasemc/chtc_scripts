#!/bin/bash
mkdir results
mv *.tar results/
mv job_* results/
cp *.log results/
cp sampling_values.txt results/sampling_values.txt
tar czf results.tar.gz results/
# scp cmclark8@submit2.chtc.wisc.edu:/home/cmclark8/results.tar.gz /Users/chase/downloads/results
