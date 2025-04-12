# Modules Notes
- as long as a file in directory has a .tf extension terraform will treat it as a config file

```hcl
module "dev-webserver" {
    source = "../aws-instance" #This is where the child module is stored
}

```

## Creating and using a Module

## Using modules from the terraform registry
- Check for verified vs user published
- **Coding assistant generated**
  - Modules from the Terraform Registry are pre-built, reusable configurations shared by the community or verified publishers.
  Use them to simplify your infrastructure code by reducing redundancy and leveraging well-tested configurations.
  They can be directly referenced in your `.tf` files using their source as
  `registry.terraform.io/<namespace>/<module>/<provider>`.

