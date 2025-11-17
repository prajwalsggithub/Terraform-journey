terraform {
  backend "s3" {
    bucket = "ttttttttttttttp"
    key    = "terraform.tfstate"
    region = "us-west-2"
    #use_lockfile = true # to use s3 native locking 1.19 version above
    dynamodb_table = "terraform"
  }
}