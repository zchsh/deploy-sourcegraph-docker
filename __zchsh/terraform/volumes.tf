// configure a new EBS volume
resource "aws_ebs_volume" "test-data-vol" {
  // Should be the same a_z as the aws_instance
  availability_zone = aws_instance.test-ec2-instance.availability_zone
  // SourceGraph recommends a minimum of 250 GiB
  size = 250
  
  tags = {
    Name = "data-volume"
  }
}

// attach the volume to the instance
resource "aws_volume_attachment" "test-volume-attachment" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.test-data-vol.id
  instance_id = aws_instance.test-ec2-instance.id
}