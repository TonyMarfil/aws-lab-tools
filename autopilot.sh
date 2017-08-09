#!/bin/bash

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>log.out 2>&1
SECONDS=0

# install figlet
apk add figlet

figlet Here we go...

cd ~
git clone https://github.com/TonyMarfil/marfil-f5-terraform
cd ~/marfil-f5-terraform/
source ./start
terraform plan
terraform apply
duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
sleep 15m
lab-info
$(lab-info 2>/dev/null | grep ssh -m1 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m2 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m3 | tail -n1 | cut -c12-) < /bigiptest.sh
sleep 15m
lab-info
$(lab-info 2>/dev/null | grep ssh -m1 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m2 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m3 | tail -n1 | cut -c12-) < /bigiptest.sh

figlet Triggering autoscale WAF...

wafUrl=$(lab-info | grep "WAF ELB" -A 2 | tail -n2 | cut -c8-)
base64 /dev/urandom | head -c 3000 > payload
ab -t 180 -c 200 -c 5 -T 'multipart/form-data; boundary=1234567890' -p payload $wafUrl/
sleep 15m
lab-info
$(lab-info 2>/dev/null | grep ssh -m1 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m2 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m3 | tail -n1 | cut -c12-) < /bigiptest.sh

figlet Cleaning up and destroying lab...

lab-cleanup
terraform destroy -force
terraform destroy -force
deleteBucket.sh

figlet FIN
