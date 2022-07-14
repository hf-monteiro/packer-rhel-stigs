build {

  name = "linux-builder"
  source "source.amazon-ebs.vm" {
    ssh_username = "ec2-user"
  }
  
  provisioner "file" {
    source = "../ansible_rhel7_stig"
    destination = "/tmp/"
  }

  provisioner "ansible" {
    playbook_file = "../ansible_rhel7_stig/install_ansible.yml"
  }

  provisioner "shell" {
    inline = [
      "ansible-playbook -i /tmp/ansible_rhel7_stig/inventory -c local --tags low_severity --skip-tags sudo_remove_nopasswd /tmp/ansible_rhel7_stig/apply_stigs.yml",
      "ansible-playbook -i /tmp/ansible_rhel7_stig/inventory -c local --tags medium_severity --skip-tags sudo_remove_nopasswd /tmp/ansible_rhel7_stig/apply_stigs.yml",
      "ansible-playbook -i /tmp/ansible_rhel7_stig/inventory -c local --tags high_severity --skip-tags sudo_remove_nopasswd /tmp/ansible_rhel7_stig/apply_stigs.yml"
      ]
  }

}