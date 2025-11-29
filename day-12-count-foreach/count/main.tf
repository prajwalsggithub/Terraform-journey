provider "aws" {
  
}


# resource "aws_instance" "name" {
#     ami = "ami-04f9aa2b7c7091927"
#     instance_type = "t3.micro"
#     count = 2
    

# tags = {
#     Name = "test-${count.index}"
# }
# }

variable "env" {
    type = list(string)
    default = [ "dev","test"]
  
}

resource "aws_instance" "name" {
    ami = "ami-04f9aa2b7c7091927"
    instance_type = "t3.micro"
    count = length(var.env) #3 servers
    # tags = {
    #   Name = "dev"
    # }
  tags = {
      Name = var.env[count.index] #dev,prod,test
    }
}