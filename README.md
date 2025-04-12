# Terraform Practice

---

### Using infracost

- Useful for predicting the cost of an planned infrastructure deployment

```bash

##Needs to be executed from the correct directory
terraform init
terraform plan -out=tfplan
infracost breakdown --path=tfplan

```