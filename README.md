## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

(Images/Red_Team_Network_Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - (Resources/config_file/install-elk.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting inbound access to the network. The load balancer ensures that work to process incoming traffic will be shared by both vulnerable web servers. Access controls will ensure that only authorized users — namely, ourselves — will be able to connect in the first place.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the
file systems of the VMs on the network, as well as watch system metrics, such as CPU usage; attempted SSH logins; sudo escalation failures; etc.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.4   | Linux            |
| DVWA 1   |Web Server| 10.0.0.5   | Linux            |
| DVWA 2   |Web Server| 10.0.0.6   | Linux            |
| ELK      |Monitoring| 10.1.0.4   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the jumpbox machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses: 98.37.205.165


Machines within the network can only be accessed by each other. The DVWA 1 and DVWA 2
VMs send traffic to the ELK server: 10.0.0.5-6

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes                 |    98.37.205.165     |
|   ELK    | No                  |    10.0.0.1-254      |
|  DVWA 1  | NO                  |    10.0.0.1-254      |
|  DVWA 2  | NO                  |    10.0.0.1-254      |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it streamlines the configuration process. Instead of individually installing on all machines you can simply deploy a playbook that automates this process.

The playbook implements the following tasks:
- Install Docker.
- Install Pip3
- Increse Memory
- Download Elk Image
- Enable Docker on Boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

(Images/docker_ps_output.png)

### Target Machines & Beats

This ELK server is configured to monitor the DVWA 1 and DVWA 2 VMs, at 10.0.0.5 and 10.0.0.6, respectively.

We have installed the following Beats on these machines: - Filebeat - Metricbeat - Packetbeat

These Beats allow us to collect the following information from each machine: Filebeat: 
- Filebeat detects changes to the filesystem. Specifically, we use it to collect Apache logs. 
- Metricbeat: Metricbeat detects changes in system metrics, such as CPU usage. We use it to detect SSH login attempts, failed sudo escalations, and CPU/RAM statistics. 
- Packetbeat: Packetbeat collects packets that pass through the NIC, similar to Wireshark. We use it to generate a trace of all activity that takes place on the network, in case later forensic analysis should be warranted.

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the playbook file to the Ansible Control Node.
- Update the host file to include specification of which VMs will be used to run the playbook.
- Run the playbook, and navigate to /etc/ansible to check that the installation worked as expected.


The easiest way to copy the playbooks is to use Git:
 $ cd /etc/ansible
 $ mkdir files
 # Clone Repository + IaC Files
 $ git clone https://github.com/yourusername/project-1.git
 # Move Playbooks and hosts file Into `/etc/ansible`
 $ cp project-1/playbooks/* .
 $ cp project-1/files/* ./files
This copies the playbook files to the correct place.

Next, you must create a hosts file to specify which VMs to run each playbook on. Run the commands below
 $ cd /etc/ansible
 $ cat > hosts <<EOF
 [webservers]
 10.0.0.5
 10.0.0.6
 [elk]
 10.0.0.8
 EOF
 
After this, the commands below run the playbook:
  $ cd /etc/ansible
  $ ansible-playbook install_elk.yml elk
  $ ansible-playbook install_filebeat.yml webservers
  $ ansible-playbook install_metricbeat.yml webservers
To verify success, wait five minutes to give ELK time to start up.
Then, run: curl http://10.0.0.8:5601 . This is the address of Kibana. If the installation succeeded, this command should print HTML to the console.