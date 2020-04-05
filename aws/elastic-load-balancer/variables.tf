variable "name" {
  description = "The name to use for domain certificate manager"
  type        = string
}
variable "bucket" {
  description = "The name bucket to use for elb"
  type        = string
  default     = "DNS"
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