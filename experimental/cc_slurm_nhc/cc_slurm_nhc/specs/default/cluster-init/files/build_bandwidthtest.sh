#!/bin/bash

source common_functions.sh

if ! is_slurm_controller; then
   cd /usr/local/cuda/samples/1_Utilities/bandwidthTest
   make
fi
