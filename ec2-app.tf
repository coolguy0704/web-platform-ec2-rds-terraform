resource "aws_instance" "a" {
  ami                    ="ami-0c3fd0f5d33134a76"
  vpc_security_group_ids =[aws_security_group.for_webserver_ec2.id]
  instance_type          ="t2.micro"
  subnet_id              = aws_subnet.public_a_web.id
  user_data = <<EOF
  #!/bin/bash
  yum install -y httpd
  yum install -y mysql
  systemctl start httpd
  systemctl enable httpd
  usermod -a -G apache ec2-user
  chown -R ec2-user:apache /var/www
  chmod 2775 /var/www
  find /var/www -type d -exec chmod 2775 {} \;
  find /var/www -type f -exec chmod 0664 {} \;
  echo `hostname` > /var/www/html/index.html
  EOF
}

resource "aws_instance" "c" {
  ami                    ="ami-0c3fd0f5d33134a76"
  vpc_security_group_ids =[aws_security_group.for_webserver_ec2.id]
  instance_type          ="t2.micro"
  subnet_id              = aws_subnet.public_c_web.id
  user_data = <<EOF
  #!/bin/bash
  yum update -y
  yum install -y httpd
  yum install -y mysql
  systemctl start httpd
  systemctl enable httpd
  usermod -a -G apache ec2-user
  chown -R ec2-user:apache /var/www
  chmod 2775 /var/www
  find /var/www -type d -exec chmod 2775 {} \;
  find /var/www -type f -exec chmod 0664 {} \;
  echo `hostname` > /var/www/html/index.html
  EOF
}
