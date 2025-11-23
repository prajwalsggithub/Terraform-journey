provider "aws" {
  region = "us-west-2"
}

# Use workspace name in resource naming
resource "aws_s3_bucket" "example" {
  bucket = "my-tf-demo-${terraform.workspace}-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.example.bucket
}
# What’s happening:
# The ${terraform.workspace} variable inserts the workspace name into the bucket name.
# Each workspace will create its own unique bucket.
# Then:

# Workspace	Bucket Name	State File
# dev	my-tf-demo-dev-bucket	terraform.tfstate.d/dev/terraform.tfstate
# prod	my-tf-demo-prod-bucket	terraform.tfstate.d/prod/terraform.tfstate