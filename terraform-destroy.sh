#!/bin/bash
cd ~/marfil-f5-terraform
source ~/.profile
lab-cleanup
terraform destroy -force
terraform destroy -force

# Do not delete bucket since some buckets were deleted before terraform destroy completed.
# deleteBucket.sh
