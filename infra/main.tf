resource "aws_key_pair" "wp_key" {
  key_name   = var.ssh_key_name
  public_key = file("~/.ssh/id_rsa.pub") # Adjust if using a different key
}

resource "aws_security_group" "wp_sg" {
  name        = "wp-sg"
  description = "Allow SSH, HTTP, and MySQL"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # In production, restrict to EC2 IP only
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks =_
