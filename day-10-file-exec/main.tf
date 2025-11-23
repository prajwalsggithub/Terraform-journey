# 
provider "aws" {
  
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "TF-IGW"
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.name.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public-RT"
  }
}

# Associate the Route Table with your subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "TF-VPC-2"
    }
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "Public-Subnet-1"
    }
}

resource "aws_security_group" "name" {
    name = "EC2-Connection"
    description = "Allow SSH Connection"
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "SSH"
    }
    ingress{
        description = "SSH for all"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

resource "aws_instance" "ec2" {
  ami = "ami-04f9aa2b7c7091927"
  instance_type = "t3.micro"
  key_name = "first"
  vpc_security_group_ids = [aws_security_group.name.id]
  subnet_id = aws_subnet.public.id
  associate_public_ip_address = true
}


# Part	Purpose
# provisioner "file"	Copies the local file (file1.txt) to the EC2 instance
# connection {}	Defines how Terraform connects to EC2 — via SSH, using your private key
# triggers	Forces Terraform to rerun the provisioner if something changes
# filemd5("file1.txt")	Calculates a hash (fingerprint) of your file; if file content changes, Terraform detects it and re-runs provisioner
 
 resource "null_resource" "copy_file" {
  provisioner "file" {
    source      = "file1.txt"
    destination = "/tmp/file1.txt"
  
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("C:\\Users\\Prajawal\\.ssh\\first.pem")
      host        = aws_instance.ec2.public_ip
    }
  }

  # This part ensures it runs every time file changes
  triggers = {
    file_hash = filemd5("file1.txt")
  }
}

  

