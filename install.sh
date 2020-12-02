wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip terraform_0.13.5_linux_amd64.zip
rm -rf terraform_0.13.5_linux_amd64.zip
sudo mv terraform /usr/local/bin
terraform init
terraform apply -auto-approve
while true; do
    read -p "Do you wish to destroy the infrastructure? " yn
    case $yn in
        [Yy]* ) terraform destroy -auto-approve; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done