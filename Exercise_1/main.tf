# TODO: Designate a cloud provider, region, and credentials
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "ap-southeast-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2
resource "aws_instance" "udacity-t2" {
  ami           = "ami-0e2e292a9c4fb2f29"
  instance_type = "t2.micro"
  count         = "0"
  tags = {
    name = "Udacity T2"
    Name = "Udacity T2"
  }
  subnet_id = "subnet-03edc942cf58ffad1"
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4
resource "aws_instance" "udacity-m4" {
  ami           = "ami-0e2e292a9c4fb2f29"
  instance_type = "m4.large"
  count         = "0"
  tags = {
    name = "Udacity M4"
    Name = "Udacity M4"
  }
  subnet_id = "subnet-03edc942cf58ffad1"
}