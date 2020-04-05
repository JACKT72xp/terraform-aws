# Common variables to certificate manager

variable "domain" {
    type        =   string
    description = "define certificate-manager domain"
}

variable "validation_method" {
    type        =   string
    description = "define certificate-manager validation method"
}


variable "zone_id" {
    type        =   string
    description = "define certificate-manager zone id public domain"
}