resource "aws_instance" "test-ec2-instance" {
  # According to the "Instance Wizard" and the AWS CLI,
  # this is the correct AMI ID for:
  # Amazon Linux 2 AMI (HVM), SSD Volume Type (64-bit x86)
  ami           = "ami-0a0ad6b70e61be944"
  instance_type = "t2.micro"
  // instance_type = "c4.8xlarge"

  # Set the user_data to our bash setup script
  # ref: https://docs.sourcegraph.com/admin/install/docker-compose/aws
  # TODO: Just echoes "Hello Terraform!" right now, need to set up actual script!
  user_data = file("sourcegraph/user-data.sh")

  # Add a human-friendly name to the instance
  tags = {
    Name = "SourceGraph - Linux AMI HVM SSD"
  }

  # Configuration below was set up as part of:
  # https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f
  # ... before this, I couldn't seem to connect 
  key_name        = "tf-sourcegraph-test"
  security_groups = [aws_security_group.ingress-all-test.id]
  subnet_id       = aws_subnet.subnet-uno.id
}
  