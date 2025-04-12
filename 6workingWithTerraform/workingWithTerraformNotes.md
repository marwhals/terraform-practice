# Working with Terraform

- `terraform validate` - checks if the configuration is valid, will show the errors in the file to fix it
- `terraform fmt` - this will reformat the current working directory
- `terraform show` - it displays the current state of the resource including all the attributes created by Terraform for
  that resource, such as the file name, file and directory permissions, content and ID of the resource.
    - Can additionally make use of `-json` flag to print the content in a JSON format.
- to see a list of all providers used in the configuration directory use the `terraform providers` command.
- You can also make use of the mirror sub-command to copy provider plugins need for the current configuration to another
  directory like this.
    - `terraform providers mirror /root/terraform/new_local_file`
- If you want to print out all output variables use the command `terraform output`
- Can print the output of a specific variable using `terraform output <variable name>`
- `terraform apply -refresh-only` - used to sync Terraform with the real world infrastructure
    - If there are any changes to a resource created by Terraform outside its control, such as a manual update the
      terraform refresh command will pick it up and update the state file.
    - This reconciliation is useful to determine what action to take during the next apply.
    - This command will not modify any infrastructure but it will modify the state file
    - Terraform refresh is also run automatically by the commands, terraform plan, terraform apply and this is done
      prior to Terraform generating an execution plan.
        - This can be bypassed by using the `-refresh`
- `terraform graph` - The terraform graph command is used to create a visual representation fo the dependencies in a
  Terraform configuration or an execution plan.
    - The output of this command is in a format called "DOT"
    - This can be passed to some graph visualisation software such as GraphVIZ....or Python

# Mutable vs Immutable infrastructure

- When terraform updates a resource it first destroys it and the recreates it with the new permission.

- Mutable Infrastructure
    - Involves in-place updates to existing servers/resources
    - Can use manual steps, script or tools like Ansible
    - Risk: Configuration Drift - over time, servers may become inconsistent (e.g different versions, OS, dependencies)

- Immutable Infrastructure
    - Instead of updating, new servers are provisioned with updated software and old ones are discarded
    - Reduces configuration drift and keep systems consistent
    - Easier to version, rollback and manage with infrastructure as Code (IaC)
    - Terraform follows this model by destroying and recreating resources on changes

# Lifecycle rules

- **`create_before_destroy`**
    - Ensures a new resource is created before the old one is destroyed.
    - Useful for avoiding downtime during updates.

- **`prevent_destroy`**
    - Prevents a resource from being destroyed during a terraform apply.
    - Helps protect critical infrastructure (e.g., databases).
    - Does not prevent deletion via terraform destroy.

- **`ignore_changes`**
    - Tells Terraform to ignore specific attribute changes made outside of Terraform.
    - Useful for tags or dynamic values managed by other tools or manual processes.

# Data sources

Data sources allow Terraform to read information from infrastructure not managed by Terraform.

**Useful when resources are:**

- Provisioned manually
- Created using other tools (like Ansible, CloudFormation, etc.)
- Created by another Terraform config or outside the current directory

```hcl

# data-source.tf

# Read content from an existing file (created outside Terraform)
data "local_file" "dog" {
  filename = "/root/dogs.txt"
}

# Use the content from the data source to create a new file
resource "local_file" "pet" {
  filename = "/root/pets.txt"
  content  = data.local_file.dog.content
}
```

### Data sources vs Resources

| Resource                                  | Data source                |
|-------------------------------------------|----------------------------|
| Keyword: resource                         | Keywords: Data             |
| Creates, Updates, Destroys Infrastructure | Only Reads Infrastructure  |
| Also called Managed Resources             | Also called Data Resources |

# Meta-Arguments

## Count

```hcl

### main.tf
resource "local_file" "pet" {
  filename = var.filename[count.index]
  
  count = length(var.filename) ## take from the variables.tf file
  
}

### variables.tf

variable "filename" {
  default = [
  "/root/pets.txt",
  "/root/dogs.txt",
  "/root/cats.txt",
  "/root/cows.txt",
  "/root/monkeys.txt",
  ]
}

```
- `length` this function will return the size of a list

## for-each
- *only works with a map or a set*
  - can also use


```hcl

### main.tf
resource "local_file" "pet" {
  filename = each.value
  
  for_each = var.filename ## take from the variables.tf file
  for_each = toset(var.filename) ## take from the variables.tf file when the variable is a list
  
}

### variables.tf

variable "filename" {
  type=set(string)
  default = [
  "/root/pets.txt",
  "/root/dogs.txt",
  "/root/cats.txt",
  "/root/cows.txt",
  "/root/monkeys.txt",
  ]
}

```

## Version Constraints

- `terraform init` command downloads the latest version of the provider plugins
  - The functionality of provider plugin can vary from one provider to another
  - Can specficy a version when we use the terraform init command
    - This is avaialbe in the provider documentation in the registry

### Example
```hcl

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "1.4.0"
      version = "!= 1.4.0" # Don't use this version
    }
  }
}

resource "local_file" "pet" {
  filename = "root/pet.txt"
  content = "We love pets!"
}


```