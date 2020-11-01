# openstack-k8s

Simple k8s deployment within openstack cloud environments.
This project is based upon [Kubespray](https://github.com/kubernetes-sigs/kubespray.git)
and tries to fill in the "missing parts".

As well as providing an ready to run example including a terraform deployment.

## How to deploy

### Warning

First of all a warning, this script will generate a ssh keypari for connecting to the instances.
This keypair will be stored also within your tfstate file, so keep it as secure as `.ssh.vpass`.

### How to deploy using VS Code

1. Install all recommended extensions
1. Open the quick run dialog.
1. Click on "Run terraform init"
1. Click on "Run terraform apply"

### How to deploy from command line

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
