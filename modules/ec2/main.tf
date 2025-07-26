resource "aws_instance" "devops_ec2" {
  ami           = "ami-0dee22c13ea7a9a67" # Amazon Linux 2 AMI for ap-south-1
  instance_type = "t2.micro"
  key_name      = var.key_name  # you must have an existing keypair in AWS console

  tags = {
    Name = "DevOps2025-Instance"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install -y ruby
              amazon-linux-extras enable epel
              yum install -y wget
              cd /home/ec2-user
              wget https://aws-codedeploy-ap-south-1.s3.ap-south-1.amazonaws.com/latest/install
              chmod +x ./install
              ./install auto
              EOF
}

output "ec2_instance_id" {
  value = aws_instance.devops_ec2.id
}
