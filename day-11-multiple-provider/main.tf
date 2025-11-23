# In Terraform, a provider is a plugin that allows Terraform to talk to an external API — in this case, AWS.
# When you define multiple providers, you are telling Terraform that you want to use more than one configuration for the same (or different) provider.


provider "aws" {
    region = "us-west-2"
}

provider "aws" {
    region = "us-east-1"
    alias = "east"
}

resource "aws_instance" "west" {
    ami = "ami-04f9aa2b7c7091927"
    instance_type = "t3.micro"
    tags = {
      Name = "instance-east-1"
    }
}

resource "aws_s3_bucket" "west2" {
    bucket = "prajwal-gawande993"
    provider = aws.east
  
}

# You might use multiple providers when:
# You need to deploy resources in multiple AWS regions (like your example).
# You want to manage different AWS accounts (by using different credentials).