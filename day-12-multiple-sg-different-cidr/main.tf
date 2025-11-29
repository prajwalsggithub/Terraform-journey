variable "allowed_ports" {
  type = map(string)
  default = {
    22    = "203.0.113.0/24"    # SSH (Restrict to office IP)
    80    = "0.0.0.0/0"         # HTTP (Public)
    443   = "0.0.0.0/0"         # HTTPS (Public)
    8080  = "10.0.0.0/16"       # Internal App (Restrict to VPC)
    9000  = "192.168.1.0/24"    # SonarQube/Jenkins (Restrict to VPN)
    3389  = "10.0.1.0/24"
  }
}

resource "aws_security_group" "devops_project_prajwal" {
  name        = "devops-project-prajwal"
  description = "Allow restricted inbound traffic"

  dynamic "ingress" {
    for_each = var.allowed_ports
    content {
      description = "Allow access to port ${ingress.key}"
      from_port   = ingress.key
      to_port     = ingress.key
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
     
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-prajwal"
  }
}



#----------------------------------------------
# variable "security_groups" {
#   type = map(object({
#     description   = string
#     allowed_ports = map(string)
#   }))

#   default = {
#     web = {
#       description = "Web tier SG"
#       allowed_ports = {
#         80  = "0.0.0.0/0"
#         443 = "0.0.0.0/0"
#       }
#     }

#     app = {
#       description = "App tier SG"
#       allowed_ports = {
#         8080 = "10.0.0.0/16"
#         9000 = "192.168.1.0/24"
#       }
#     }

#     db = {
#       description = "DB tier SG"
#       allowed_ports = {
#         3306 = "10.0.1.0/24"
#       }
#     }
#   }
# }

# resource "aws_security_group" "multi_sg" {
#   for_each    = var.security_groups

#   name        = "sg-${each.key}"
#   description = each.value.description

#   dynamic "ingress" {
#     for_each = each.value.allowed_ports
#     content {
#       description = "Allow access to port ${ingress.key}"
#       from_port   = ingress.key
#       to_port     = ingress.key
#       protocol    = "tcp"
#       cidr_blocks = [ingress.value]
#     }
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "sg-${each.key}"
#   }
# }

# sg-web   → allows ports 80, 443
# sg-app   → allows ports 8080, 9000
# sg-db    → allows port 3306t