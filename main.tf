terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-04a81a99f5ec58529"
  instance_type = "t2.micro"
  key_name = "key-rsa"
  user_data = <<-EOF
                  #!/bin/bash
                  cd /home/ubuntu
                  echo "<h1>Feito com Terraform</h1>" > index.html
                  nohup busybox httpd -f -p 8080 &
                EOF
  tags = {
    Name = "AppServerInstance"
  }
}
