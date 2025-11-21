provider "aws" {
  
}

data "aws_subnet" "name" {
    filter {
    name   = "tag:Name"
    values = ["test-subnet"]
     # It does not create a subnet — it only finds one that already exists in AWS with the tag:
     #data "aws_subnet" → the type of data source
# "name" → Terraform’s internal name (you can call it anything)
# filter → tells Terraform how to search for the subnet

  }
}
data "aws_ami" "amzlinux" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*-gp2" ]
  }
             filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
        filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}
# 

resource "aws_instance" "name" {
    ami=data.aws_ami.amzlinux.id
    instance_type = "t3.micro"
    subnet_id = data.aws_subnet.name.id

}
# This is the actual EC2 instance Terraform will create.
# It uses:
# the AMI you looked up in the previous data source,
# the subnet you read from AWS,
# the instance type you specify (t3.micro here).
# So when you run terraform apply, Terraform will:
# Look up the AMI → find latest Amazon Linux 2 image
# Look up the subnet → find subnet tagged test-subnet