resource "aws_key_pair" "wp_key" {
  key_name   = var.ssh_key_name
  public_key = file("/home/john/.ssh/id_rsa.pub")
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "wp_server" {
  ami                    = "ami-04505e74c0741db8d"
  instance_type          = var.instance_type
  key_name               = var.ssh_key_name
  vpc_security_group_ids = [aws_security_group.wp_sg.id]

  tags = {
    Name = "wp-server"
  }
}

resource "aws_db_instance" "wp_db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  skip_final_snapshot  = true
  publicly_accessible  = true
  vpc_security_group_ids = [aws_security_group.wp_sg.id]
}