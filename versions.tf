terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
    local = {
      source = "hashicorp/local"
      version = "2.0.0"
    }
  }
  required_version = ">= 0.13"
}
