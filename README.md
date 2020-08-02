# openstack-k8s

Simple k8s deployment within openstack cloud environments

## How to deploy

1. Prepare
    1. Log into your openstack account and download your `openrc.sh` (OpenStack RC File v3) file.
    1. Save it as `openrc.sh` into this folder
    1. Edit the `openrc.sh` file and set your password by appending a line like this: `export OS_PASSWORD="your_password"`
    1. Source your openstack credentials `. openrc.sh`
    1. Create a new python venv `python -m venv venv`
    1. Activate the venv `source ./venv/bin/activate`
    1. Install required packages `pip3 install -r requirements.txt`
    1. Just to make sure update all packages `pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U`
    1. Initialize terraform `terraform init`
1. Create openstack resources
    1. Check the variables within `00-create-k8s-nodes.tf` and if necessary overwrite them within a `terraform.tfvars` file.
    1. Run `terraform apply` to provision your infrastrukture.
