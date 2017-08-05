#!/bin/bash
cd ~/marfil-f5-terraform
source ~/.profile
lab-cleanup
terraform destroy -force
terraform destroy -force
deleteBucket.sh

