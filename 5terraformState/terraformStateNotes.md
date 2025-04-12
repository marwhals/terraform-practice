# Terraform state

- Terraform state is a single source of truth to understand what is deployed in the real world
  - Non-optional in terraform
- Considerations
  - The state file contains sensitive information about infrastructure
    - Need to make sure the state file is in secure storage
    - Good practice to store these things in secure backend systems such as AWS S3 and equivalents
- Terraform state is a JSON data structure that is meant for internal use within Terraform
  - It should not be manually edited