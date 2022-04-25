## Create base state 

1. Create secret.tfvars file has three parameter 
```
aws_access_key="YOUR_ACCESS_KEY"
aws_secret_key="YOUR_SECRET_KEY"
number_replicas_pod = NUMBER_OF_REPLICAS_POD
is_open_port_80_for_alb = true | false 

- If developing and testing set to true.
- If you want to create an error environment for the interviewer, set it to false
```

2. Create s3 bucket as backend with default parameter in backend.tf file
```
You can fully change all paramters 
```
3. Terraform init 
```
terraform init 
```

4. Terraform plan
```
terraform plan -var-file="secret.tfvars"
```

5. Terraform apply 
```
terraform apply -var-file="secret.tfvars" --auto-approve
```

6. Terraform destroy 
```
terraform destroy -var-file="secret.tfvars" --auto-approve
```