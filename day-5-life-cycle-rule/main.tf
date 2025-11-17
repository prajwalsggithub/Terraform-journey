resource "aws_vpc" "name" {
  cidr_block = "10.2.0.0/24"
  tags = {
    Name = "vpc-22"
  }

 
     lifecycle {
      ignore_changes = [tags]
     
       prevent_destroy = true
     }
}
