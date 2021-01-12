resource "aws_security_group" "ingress-all-test" {
  name   = "allow-all-sg"
  vpc_id = aws_vpc.test-env.id

  // Something to do with the tutorial I couldn't follow
  // https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f
  // I think this might just be the basic stuff required to even connect via AWS's 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // "Configure Security Group"
  // Allow HTTP on port 80
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // "Configure Security Group"
  // Allow HTTPS on port 443
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Allow outgoing traffic
  // (Terraform removes the default rule)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
