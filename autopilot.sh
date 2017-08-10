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
echo milestone: terraform apply completes
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
sleep 15m

duration=$SECONDS
echo milestone: 1st attempt to ssh to Big-IPs
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
lab-info
$(lab-info 2>/dev/null | grep ssh -m1 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m2 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m3 | tail -n1 | cut -c12-) < /bigiptest.sh
sleep 15m

duration=$SECONDS
echo milestone: 2nd attempt to ssh to Big-IPs
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
lab-info
$(lab-info 2>/dev/null | grep ssh -m1 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m2 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m3 | tail -n1 | cut -c12-) < /bigiptest.sh

figlet Triggering autoscale WAF...

duration=$SECONDS
echo milestone: launch autoscale begins
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
wafUrl=$(lab-info | grep "WAF ELB" -A 2 | tail -n2 | cut -c8-)
base64 /dev/urandom | head -c 3000 > payload
ab -t 180 -c 200 -c 5 -T 'multipart/form-data; boundary=1234567890' -p payload $wafUrl/
sleep 15m

duration=$SECONDS
echo milestone: 3rd attempt to ssh to Big-IPs
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
lab-info
$(lab-info 2>/dev/null | grep ssh -m1 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m2 | tail -n1 | cut -c12-) < /bigiptest.sh
$(lab-info 2>/dev/null | grep ssh -m3 | tail -n1 | cut -c12-) < /bigiptest.sh

figlet Cleaning up and destroying lab...

echo milestone: lab-cleanup / terraform apply begins
lab-cleanup
terraform destroy -force
terraform destroy -force
deleteBucket.sh

echo milestone: lab-cleanup / terraform apply ends
echo "$(($duration / 60)) minutes and $(($duration % 60)) seconds elapsed."
figlet FIN
