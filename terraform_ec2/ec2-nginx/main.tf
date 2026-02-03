data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "nginx_ec2" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  key_name      = var.key_name

  # Explicit default VPC subnet
  subnet_id = "subnet-0ac0db9d8472ef4d2"

  # Existing SG from same VPC
  vpc_security_group_ids = ["sg-0767e92b5dad28c15"]

  user_data = file("userdata.sh")

  tags = {
    Name = "terraform-ec2-nginx"
  }
}

