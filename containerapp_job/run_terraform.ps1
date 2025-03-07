& cls
& terraform --version
& terraform init -backend-config="resource_group_name=tfstatesa" -backend-config="storage_account_name=tf0001sa" -backend-config="key=terraform.deployment.tfplan"
& terraform workspace select dev 
& terraform validate
& terraform plan -out "terraform.deployment.tfplan"
#& terraform apply terraform.deployment.tfplan