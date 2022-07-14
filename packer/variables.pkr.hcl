variable "region" {
  type    = string
  default = "us-east-1" #default region 
}

variable "instance_type" {
  type    = string
  default = "t3.micro" #EC2 size
}

variable "ami_name" {
  type    = string
  default = "defaul-ami-rhel7-name" 
}

variable "base_ami" {
  type    = string
  default = "ami-00000w0000" #AMI ID information (you can find that information on your AWS account)
}

variable "subnet_id" {
  type    = string
  default = "subnet-00000w0000" #subnet ID information (you can find that information on your AWS account)
}

variable "security_group_id" {
  type    = string
  default = "sg-00000w0000" #SG ID information (you can find that information on your AWS account)
}
