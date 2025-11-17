resource "aws_instance" "name" {
    ami = "ami-06d455b8b50b0de4d"
    instance_type = "t3.micro"
    availability_zone = "us-west-2a"
    tags = {
        Name = "my_instance"
    }

}

resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "vpc-1"
    }
  
}