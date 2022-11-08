resource "aws_lb" "for_webserver" {
  name               = "webserver-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups    = [
    aws_security_group.alb.id
  ]

  subnets            = [
      aws_subnet.public_a.id,
      aws_subnet.public_c.id,
  ]
}

resource "aws_security_group" "alb" {
    name ="alb"
    vpc_id= aws_vpc.example.id
    ingress{
        from_port = 80
        to_port   = 80
        protocol  = "tcp"
        cidr_blocks =["0.0.0.0/0"]
    }
   egress{
       from_port  = 0
       to_port    = 0
       protocol   = "-1"
       cidr_blocks=["0.0.0.0/0"]
   }
}
