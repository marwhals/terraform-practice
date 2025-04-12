# Terraform Basics

## Using terraform providers

- After writing a Terraform configuration file we want to initialise the directory using the `terraform init` command
    - Terraform will download and install the plugins for the providers used within the configuration file
        - Could be for providers like AWS, GCP, Azure etc. Includes local providers
- Terraform uses a local plugin based architecture to work with these different infrastructure platforms
- Terraform providers are distributed by HashiCorp and are publicly available in the Terraform Registry
  `registry.terraform.io`
- Three tiers of providers
    - Official provider - These are owned and maintained by HashiCorp and include all the major cloud providers. Local
      provider is also an official provider
    - Partner Provider - A partner provider is owned and maintained by a third party technology company that has gone
      through the a partner provider process with HashiCorp
    - Community Provider - Providers that are maintained by individual contributors of the HashiCorp community.

- A `terraform init` command when run shows the version of the plugin that has been installed
    - It is a safe command and can be run as many times as needed without impacting the actual infrastructure that has
      been deployed
    - Plugins are downloaded into a hidden directory called `.terraform/plugins` in the working directory containing the
      configuration files.
    - `* hashicorp/local version = "~> 2.0.0"` - hashicorp/local is known as the source address that Terraform will use
      to local and download the plugin from the registry
        - `hashicorp` is known as the organisational namespace `local` is the type which is the name of the
            - Can optionally have a hostname in front. This is where the plugin is located, if ommitted it defaults to
              `registry.terrafomr.io` which is HashiCorp's public registry
- By default, Terraform installs the latest version of the provider.
    - Provider plugins, especially the official ones are constantly updated with the newer versions.
        - *Typically, these are bug fixes or new functionality but this can introduce breaking changes in the code.
        - Can lock down out configuration files to make use of a specific provider version as well.

## Configuration Directory

- Terraform will consider a file with the .tf extension within the configuration directory
- Another common practice is to have one configuration file that contains all the resource blocks required to provision
  the infrastructure
    - A single configuration file can have as many number of configuration blocks that you need.
- A common naming convention used for such a configuration file is to call it `main.tf`
- There are other configuration files that can be created within the directory

| File Name      | Purpose                                                |
|----------------|--------------------------------------------------------|
| `main.tf`      | Main configuration file containing resource definition |
| `variables.tf` | Contains variable definitions                          |
| `outputs.tf`   | Contains outputs from resources                        |
| `provider.tf`  | Contains provider definition                           |

## Variables in terraform

| Type   | Example                                                 |
|--------|---------------------------------------------------------|
| string | "/root/abc.txt"                                         |
| number | 1                                                       |
| bool   | `true` / `false`                                        |
| any    | Default Value                                           |
| list   | ["dog", "bear"]                                         |
| map    | pet1 = cat<br/>pet2 = monkey                            |
| object | { name = "Alice",<br/> age = 30, <br/>is_admin = true } |
| tuple  | [40.7128, -74.0060]                                     |

*can be used for type constraints* - when running `terraform plan` it will check the types for any errors

## Using variables in terraform

- Can specify variable in interactive mode at command prompt
- Can also `terraform apply -var "filename=/root/pets.txt" -var "content=We love pets -var......"` etc
- `export TF_VAR_example_variable="Hello, Terraform!"
- can also use variable files like in a .tfvars file or a .tfvars.json
    - *.auto.tfvars or *.auto.tfvars.json will be automatically loaded by terraform
    - `terraform apply -var-file variable.tfvars`

## Terraform variable definition precedence

| File Name | Purpose                                |
|-----------|----------------------------------------|
| 1         | Environment variables                  |
| 2         | terraform.tfvars                       |
| 3         | *.auto.tfvars (alphabetical order)     |
| 4         | -var or -var-file (command-line flags) |


# Resource attributes

# Resource dependencies

- Implicit dependency - terraform figures out which resources are dependent on other resources
- can also add a depends on block within the resource *explicit dependency*
```hcl

depends_on = [
    random_pet.my-pet
]

```


# Output variables
```hcl
output "<variable_name>" {
  value = "<variable_value>"
  <arguments>
}
```
- will see these variables via the `terraform output` command
- *these can be useful as input to ansible or a shell script*