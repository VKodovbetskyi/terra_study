# We use Frankfurt region for our t2-instances

provider "aws" {
  alias  = "t2"
  region = var.regions[1]
}

resource "aws_instance" "t2" {
  provider               = aws.t2
  count                  = 2
  ami                    = var.amis[var.regions[1]]
  instance_type          = var.instance_types[0]
  key_name               = var.region_aliases[1]
  vpc_security_group_ids = [aws_security_group.allow_ssh_frankfurt.id]
  root_block_device {
    volume_size = 10
  }
}

resource "aws_security_group" "allow_ssh_frankfurt" {
  provider    = aws.t2
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
