# Terraform Taint notes

### Terraform Taint Command - *GPT generated*

The `terraform taint` command is used to manually mark a specific resource for destruction and recreation during the
next `terraform apply`. This is useful when you want to force the recreation of a resource due to issues or specific
changes that require rebuilding it, even if the resource's configuration has not changed.

#### Syntax

```bash
terraform taint [options] <resource_address>
```

- **`<resource_address>`**: The address of the specific resource to mark as tainted (e.g., `aws_instance.example`).

#### Example Usage

```bash
terraform taint aws_instance.example
```

In this example, the `aws_instance.example` resource will be tainted and recreated on the next `terraform apply`.

#### Options

- **`-lock=false`**: Disable locking of the state file during the operation.
- **`-lock-timeout=0s`**: Specify a duration to wait for a state lock.
- **`-allow-missing`**: Proceed even if the specified resource does not exist in the state.

#### When to Use `terraform taint`

- To force the recreation of a resource when its state is suspected to be corrupted.
- After manual alterations to a resource outside of Terraform that may cause issues.
- In scenarios where automatic detection of changes does not trigger a recreation but it is explicitly required.

#### Behavior

Once a resource is tainted, it will appear in the plan with the status indicating it will be destroyed and recreated.
For example:

```bash
# terraform plan
-/+ aws_instance.example (tainted)
```

#### Reversing Taint

If you mistakenly taint a resource, you can "untaint" it with the `terraform untaint` command:

```bash
terraform untaint aws_instance.example
```

This will remove the taint marking and prevent recreation on the next `terraform apply`.

#### Notes

- Use the `terraform state list` command to locate resource addresses if needed.
- Be cautious when using this command in collaborative environments as it modifies the state directly.

## Debugging

- `export TF_LOG=TRACE`
  - Terraform offers five log levels: INFO, WARNING, ERROR, DEBUG, TRACE
- to store to a file `export TF_LOG_PATH=/tmp/terraform.log`

## Terraform Import Command
- Brings a resource completely in the control of Terraform (note data is not in the control of terraform although it can be used in tf files)
- `terraform import <resource_type>.<resource_name> <attribute>`

```hcl
resource "aws_instance" "webserver-2" {
    # (resource arguments)
}

```