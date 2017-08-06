Automation and testing tools for the F5 "Deploying BIG-IP Virtual Edition" in AWS lab
-------------------------------------------------------------------------------------
http://clouddocs.f5.com/training/community/public-cloud/html/class1/class1.html

With the spawn-lab command you can:

- Trigger, run through and destroy cleanly an arbitrary number of labs.
- Log all of the console output for each lab environment.
- Confirm AWS capacity limits and identify problems early.
- Prepare a lab variant that bypasses onboarding and starts the students in a working environment.

Tested on Ubuntu 16.04.

Install Docker
https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/

spawn-lab can run any tmsh commands by editing bigiptest.sh and change the interval at which the commands run by editing autopilot.sh.

Assumming shortUrl is abc123; to launch spawn-lab for 50 users ranging from user11 to user60.

.. code-block:: bash

   git clone https://github.com/TonyMarfil/aws-lab-tools.git
   cd ~/aws-lab-tools
   chmod +x ./spawn-lab
   chmod +x ./zap-lab
   export START=11
   export END=60
   export shortUrl=abc123
   ./spawn-lab &

You can then ssh to port 22XX to any of the 50 running containers and track progress live. Example for user11:

.. code-block:: bash

   ssh -p 2211 snops@localhost
   default
   su -
   default
   source ~/.profile
   tail -f /log.out

...or parse the entire log.out from the beginning:

.. code-block:: bash

   cat /log.out | less -R

Example screencast:
https://asciinema.org/a/aAyoHOfKUjluNK9gaOlP7lErr
-------