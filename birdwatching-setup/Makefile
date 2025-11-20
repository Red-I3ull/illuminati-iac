.PHONY: init plan apply destroy
ENV=prod-01


init:
	terraform init -backend-config="./backends/${ENV}.tfbackend" -reconfigure

plan: init
	terraform plan -var-file=workspace_vars/${ENV}.tfvars

apply: init
	terraform apply -var-file=workspace_vars/${ENV}.tfvars

destroy: init
	terraform destroy -var-file=workspace_vars/${ENV}.tfvars