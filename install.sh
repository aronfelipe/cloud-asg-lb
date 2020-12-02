wget https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
unzip terraform_0.12.24_linux_amd64.zip
mv terraform ~/bin
git clone https://e34676733fba490b4f5b8c0f41351e6a52521e8c@github.com/aronfelipe/cloud-asg-lb
cd cloud-asg-lb
terraform init
terraform apply -auto-approve