# We use Stockholm region for our t3-instances

provider "aws" {
  alias  = "t3"
  region = var.regions[2]
}

resource "aws_instance" "t3" {
  provider               = aws.t3
  count                  = 4
  ami                    = var.amis[var.regions[2]]
  instance_type          = var.instance_types[1]
  key_name               = var.region_aliases[2]
  vpc_security_group_ids = [aws_security_group.allow_ssh_stockholm.id]
  root_block_device {
    volume_size = 10
  }
}

resource "aws_security_group" "allow_ssh_stockholm" {
  provider    = aws.t3
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
