Red Hat Enterprise Linux 7 DISA STIG image creation with Packer
=========
This project uses [Packer](https://www.packer.io/)+[Ansible](https://www.ansible.com/) to build an DISA STIG compliant RHEL7 image on AWS.

Requirements
------------
- Red Hat Enterprise Linux 7 (Other versions are not supported.)
- AWS CLI - [install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- AWS IAM programmatically credentials
- Packer installed - [install Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli)
- Ansible installed - [install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

Packer variables file
----------------
All the adjustments/definitions are made on the `variables.pkr.hcl` file.


Dependencies
------------

The following packages must be installed on the controlling host/host where ansible is executed:

- gcc
- openssl-devel
- bzip2-devel
- libffi-devel
- zlib-devel
- wget
- libsemanage-python

Role Variables
--------------

Please see the Ansible docs for understanding [variable precedence](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable) to tailor for your needs. 

| Tag                     | Default Value       | Description                   |
|--------------------------|-----------------------------------------------------|----------------------|
| `high_severity` | `yes`  see defaults/main.yml](./defaults/main.yml)  | Correct CAT I findings        |
| `medium_severity` | `yes`  see defaults/main.yml](./defaults/main.yml)  | Correct CAT II findings       |
| `low_severity` | `yes`  see defaults/main.yml](./defaults/main.yml)  | Correct CAT III findings      |


## Testing
```shell
ansible-playbook -i inventory --tags "low_severity" --skip-tags "sudo_remove_nopasswd" playbook.yml
```

### Image builder
Configure the file `playbook.yml` to run locally 
```
    host: localhost
```

Running the ansible-playbook locally:
```shell
ansible-playbook -i "localhost," -c local --tags "low_severity" --skip-tags "sudo_remove_nopasswd" playbook.yml
ansible-playbook -i "localhost," -c local --tags "medium_severity" --skip-tags "sudo_remove_nopasswd" playbook.yml
ansible-playbook -i "localhost," -c local --tags "high_severity" --skip-tags "sudo_remove_nopasswd" playbook.yml
```
Packer usage
----------------
1. With your IAM programmatically credentials, login to  AWS CLI running:
```shell
aws configure
```

2. Run the following command on the `packer` folder, to initialize the modules 
```shell
packer init .
```
3. Run the following command to validate all the infrastructure that Packer will deploy on AWS:
```shell
packer validate . 
```
 4. Run the following command to deploy the EC2 on AWS, to build the image:
```shell
packer build . 
```