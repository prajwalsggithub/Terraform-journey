resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc-1"
  }
}
resource "aws_subnet" "name" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.0.0/24"
    availability_zone = "us-west-2b"
    tags = {
      Name = "pub-subnet-1"
    }
  
}
resource "aws_subnet" "name-2" {
   vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-west-2a"
    tags = {
      Name = "private-subnet-1"
    }
  
}
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
      Name = "igw-1"
    }
  
}
 #create EIP for Nat Gateway
 resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-eip"
  }
 } 
#create Nat Gateway
resource "aws_nat_gateway" "nat-gw" {
    allocation_id = aws_eip.nat_eip.id
    subnet_id = aws_subnet.name.id
    tags = {
      Name = "nat-gw-1"
    }
  
}



resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
 route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
 }

   }
   resource "aws_route_table_association" "name" {
    subnet_id = aws_subnet.name.id
    route_table_id = aws_route_table.name.id
     
   }

   # creat Route table for private subnet
   resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.name.id
    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw.id
    }
     
   }
   #associate private subnet with route table
    resource "aws_route_table_association" "name-2" {
     subnet_id = aws_subnet.name-2.id
     route_table_id = aws_route_table.name.id
      
    }

   #create sg
   resource "aws_security_group" "sg-1" {
    name  = "allow-ssh-http"
    vpc_id = aws_vpc.name.id
    tags = {
        name = "sg-1"
    }
    ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    }
    #create server
    resource "aws_instance" "pvt-1" {
        ami = "ami-06d455b8b50b0de4d"
        instance_type = "t3.micro"
        subnet_id = aws_subnet.name-2.id
        vpc_security_group_ids = [aws_security_group.sg-1.id]
        tags = {
            Name = "private-ec2-1"
        }

    }
    resource "aws_instance" "pub-1" {
       ami = "ami-06d455b8b50b0de4d"
        instance_type = "t3.micro"
        subnet_id = aws_subnet.name.id
        associate_public_ip_address = true
        vpc_security_group_ids = [aws_security_group.sg-1.id]
        tags = {
            Name = "public-ec2-1"
        }
    }






  

