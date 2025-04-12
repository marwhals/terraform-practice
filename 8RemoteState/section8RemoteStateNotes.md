# Terraform Remote State

Use cases
- Mapping terraform configuration to real world infrastructure
- Tracking metadata such as dependencies, which allow Terraform to create and delete resources in the correct order, improving the performance of Terraform operations, while working with large configuration files.
  - Especially those that make use of a number of different cloud providers.
- Terraform state allows members of a team to collaborate and provision resources as a team.

**It is not a good idea to store the state file in a version control system, since it would mostly contain sensitive information**

- When working as a team it is important that only one person runs operations against the same configuration and state at any given time using the exact same state file.
  - Avoid unintended consequences such as corruption of the state file

- Terraform has a feature called state locking i.e creates a lock file after the apply command has been issued
- If a user forgets to pull the latest version of the state file and works with an obsolete version then the effects can be disastrous, such as rollback or even the destruction of resources.


- When a remote backend is configured, Terraform will automatically load the state file from the shared storage every time it is required by a Terraform operation.
  - It will also upload the updated Terraform operation state file after every apply.
    - Importantly, many remote backend options like AWS S3 allows for state locking.
    - This ensures that the integrity of the state file is maintained.
    - Remote backends also provide different ways to secure the storage, such encryption at rest and in transit.
      - This makes sure that all the sensitive information stored inside is secured.

## Remote backends with S3

- Need an S3 bucket and Dynamo DB table

```hcl

resource "local_file" "pet" {
  filename = "root/pets.txt"
  content = "We love pets!"
}


terraform {
  backend "s3" {
    bucket = "abc-bucket01"
    key = "finance/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "state-locking"
  }
}

```

## Terraform State commands

- `terraform state <command>`

| Command                            | Description                                                               |
|------------------------------------|---------------------------------------------------------------------------|
| `terraform state list`             | Lists all resources in the state file.                                    |
| `terraform state pull`             | Displays the current state file in raw format.                            |
| `terraform state show`             | Shows detailed information about a specific resource in the state file.   |
| `terraform state mv`               | Moves a resource to a different name or location within the state file.   |
| `terraform state rm`               | Removes a specific resource from the state file.                          |
| `terraform state push`             | Updates the remote state with a local state file.                         |
| `terraform state replace-provider` | Replaces provider references in the state file with a different provider. |

