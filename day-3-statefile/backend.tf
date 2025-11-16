terraform {
  backend "s3" {
    bucket = "bucketyty"
    key    = "day-3-statefile/terraform.tfstate"
    region = "us-west-2"
  }
}