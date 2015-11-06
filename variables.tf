variable "api_key" {}
variable "secret_key" {}
variable "project" {}

variable "api_url" {
    default = "https://compute-east.cloud.ca/client/api"
}
variable "zone" {
    default = "QC-1"
}
variable "vpc_offering" {
    default = "Default VPC offering"
}
variable "disk_offering" {
    default = "20GB - 100 IOPS Min."
}
variable "compute_offering" {
    default = "2vCPU.2GB"
}
variable "network_offering" {
    default = "DefaultIsolatedNetworkOfferingForVpcNetworks"
}
variable "compute_template" {
    default = "CoreOS Stable"
}
