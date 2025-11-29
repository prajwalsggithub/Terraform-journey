variable "env" {
    type = list(string)
    default = [ "test","prod"]
  
}


resource "aws_instance" "name" {
    ami = "ami-04f9aa2b7c7091927"
    instance_type = "t3.micro"
 for_each = toset(var.env)
    tags = {
        Name = each.value
        }
    
  
}
#overcome count limitations with for_each