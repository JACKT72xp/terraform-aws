# Specify the provider and access details
provider "aws" {
  region = var.region
}
### Network
resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"
}

resource "aws_subnet" "subnet_ect" {
  cidr_block = "10.0.1.0/24"
  ##availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  vpc_id            = "${aws_vpc.main.id}"
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_web"
  description = "Allow web inbound traffic"
  vpc_id      = "${aws_vpc.main.id}"

  ingress {
    description = "web port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = "${aws_vpc.main.cidr_block}"
  }

  tags = {
    Name = "allow_web"
  }
}

resource "aws_alb" "alb_front" {
	name		=	"front-alb"
	internal	=	false
	security_groups	=	["${aws_security_group.allow_tls.id}"]
	subnets		=	["${aws_subnet.subnet_ect.id}"]
	enable_deletion_protection	=	true
}
resource "aws_alb_target_group" "alb_front_https" {
	name	= "alb-front-https"
	vpc_id	= "${aws_vpc.main.id}"
	port	= "443"
	protocol	= "HTTPS"
	health_check {
                path = "/healthcheck"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200-308"
        }
}

resource "aws_alb_listener" "alb_front_https" {
	load_balancer_arn	=	"${aws_alb.alb_front.arn}"
	port			=	"443"
	protocol		=	"HTTPS"
	ssl_policy		=	"ELBSecurityPolicy-2016-08"
	certificate_arn		=	var.arn_certificate

	default_action {
		target_group_arn	=	"${aws_alb_target_group.alb_front_https.arn}"
		type			=	"forward"
	}
}

resource "aws_lb_listener_certificate" "url2_valouille_fr" {
  listener_arn    = "${aws_alb_listener.alb_front_https.arn}"
  certificate_arn = var.arn_certificate
} 