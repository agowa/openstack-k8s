# Define variables with there default values
variable "master-node-count" { default = "2" }
variable "worker-node-count" { default = "2" }
variable "image-name" { default = "Ubuntu 20.04 Focal Fossa - Latest" }
variable "master-node-image-flavor" { default = "m1.small" }
variable "worker-node-image-flavor" { default = "m1.small" }
variable "dns-nameservers" { default = "2001:4860:4860::6464,2001:4860:4860::64,2606:4700:4700::64,2606:4700:4700::6400" }
variable "provider-subnetpool-name" { default = "customer-ipv6" }
variable "dns-domain" { default = "example.innovo.cloud." }
variable "soa-mail-address" { default = "hostmaster@example.innovo.cloud"}
