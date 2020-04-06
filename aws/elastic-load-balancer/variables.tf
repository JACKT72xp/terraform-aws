variable "name" {
  description = "The name to use for domain certificate manager"
  type        = string
}
variable "bucket" {
  description = "The name bucket to use for elb"
  type        = string
  default     = "DNS"
}
variable "tag" {
  description = "The tag to use for elb"
  type        = string
  default     = "ALB"
}
variable "bucket_prefix" {
  description = "The bucket_prefix path elb"
  type        = string
}
variable "instance_port" {
  description = "The instance_port to elb"
  type        = string
}
variable "instance" {
  description = "The instance id to elb"
  type        = string
}
variable "name" {
  description = "The name to elb"
  type        = string
}
variable "region" {
  description = "The name to region elb"
  type        = string
}
variable "domain" {
  description = "The name to domain elb"
  type        = string
}
variable "alb_target_group_name" {
  description = "The name to alb target group"
  type        = string
}
variable "alb_target_group_name_port" {
  description = "The port to alb target group"
  type        = string
}
variable "alb_target_group_name_tag_name" {
  description = "The port to alb target group"
  type        = string
}
variable "arn_certificate" {
  description = "The arn certificate alb"
  type        = string
}

