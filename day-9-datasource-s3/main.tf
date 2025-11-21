provider "aws" {
  region = "us-west-2"
}

# 📖 Read the existing S3 bucket
data "aws_s3_bucket" "shared" {
  bucket = "prajwal-demo-bucket-2025"
}

# 🗂️ Upload a file to the existing bucket
resource "aws_s3_object" "upload" {
  bucket = data.aws_s3_bucket.shared.id   # use data source bucket
  key    = "s3.txt"
  source = "s3.txt"                       # this file must exist locally
}



