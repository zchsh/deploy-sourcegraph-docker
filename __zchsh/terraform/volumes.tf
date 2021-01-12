resource "aws_ebs_volume" "test-data-vol" {
  availability_zone = aws_instance.test-ec2-instance.availability_zone
  size = 250
  
  tags = {
    Name = "data-volume"
  }
}

resource "aws_volume_attachment" "test-volume-attachment" {
  device_name = "/dev/sdb"
  volume_id = aws_ebs_volume.test-data-vol.id
  instance_id = aws_instance.test-ec2-instance.id
}