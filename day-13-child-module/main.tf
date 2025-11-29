module "vpc" {
    source = "./modules/vpc"
    cidr_blocks = "10.0.0.0/16"
    subnet_1_cidr = "10.0.1.0/24"
    subnet_2_cidr = "10.0.2.0/24"
    az1 = "us-west-2a"
    az2 = "us-west-2b"
  
}
module "rds" {
    source = "./modules/rds"
    subnet_1_id = module.vpc.subnet_1_id
    subnet_2_id = module.vpc.subnet_2_id
    instance_class = "db.t3.micro"
    db_name = "mydatabase"
    db_user = "admin"
    db_password = "Prajwal123"
  
}
module "s3" {
    source = "./modules/s3"
    bucket = "my-prajwal-bucket-1234567890"
  
}
module "ec2" {
    source = "./modules/ec2"
    ami_id = "ami-04f9aa2b7c7091927"
    instance_type = "t3.micro"
    subnet_2_id = module.vpc.subnet_2_id
  
}
