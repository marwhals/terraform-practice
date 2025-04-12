# Terraform Functions and Conditional Expressions

## More Terraform Functions

- test commands using `terraform console`

| **Function**   | **Description**                                                                      |
|----------------|--------------------------------------------------------------------------------------|
| `abs()`        | Returns the absolute value of a number.                                              |
| `ceil()`       | Rounds a number up to the nearest whole number.                                      |
| `floor()`      | Rounds a number down to the nearest whole number.                                    |
| `min()`        | Returns the smallest value from a set of numbers.                                    |
| `max()`        | Returns the largest value from a set of numbers.                                     |
| `join()`       | Joins a list of strings into a single string with a specified delimiter.             |
| `split()`      | Splits a string into a list of substrings based on a specified delimiter.            |
| `concat()`     | Combines two or more lists into a single list.                                       |
| `length()`     | Returns the number of elements in a list or the number of characters in a string.    |
| `lookup()`     | Returns the value of a key from a map, or a default value if the key is not present. |
| `element()`    | Retrieves a single element from a list by its index.                                 |
| `file()`       | Reads the contents of a file as a string.                                            |
| `replace()`    | Substitutes occurrences of a substring within a string with another substring.       |
| `merge()`      | Combines two or more maps into one map.                                              |
| `tomap()`      | Converts an object into a map type.                                                  |
| `tolist()`     | Converts an object into a list type.                                                 |
| `upper()`      | Converts a string to uppercase.                                                      |
| `lower()`      | Converts a string to lowercase.                                                      |
| `startswith()` | Returns `true` if a string starts with a specified substring.                        |
| `endswith()`   | Returns `true` if a string ends with a specified substring.                          |
| `contains()`   | Checks if a list contains a specified element or a map contains a specified key.     |
| `coalesce()`   | Returns the first non-null value from a list of arguments.                           |
| `trimspace()`  | Removes leading and trailing whitespace from a string.                               |
| `keys()`       | Returns the keys of a map as a list.                                                 |
| `values()`     | Returns the values of a map as a list.                                               |

## Conditional expressions

| **Operator**                           | **Description**                                                                                                           |
|----------------------------------------|---------------------------------------------------------------------------------------------------------------------------|
| `condition ? true_value : false_value` | Conditional expression that evaluates to `true_value` if the condition is true; otherwise, it evaluates to `false_value`. |
| `==`                                   | Equality operator. Returns `true` if the operands are equal.                                                              |
| `!=`                                   | Not equal operator. Returns `true` if the operands are not equal.                                                         |
| `<`                                    | Less-than operator. Returns `true` if the left operand is less than the right operand.                                    |
| `<=`                                   | Less-than-or-equal operator. Returns `true` if the left operand is less than or equal to the right operand.               |
| `>`                                    | Greater-than operator. Returns `true` if the left operand is greater than the right operand.                              |
| `>=`                                   | Greater-than-or-equal operator. Returns `true` if the left operand is greater than or equal to the right operand.         |
| `&&`                                   | Logical AND operator. Returns `true` if both operands are true.                                                           |
| `                                      |                                                                                                                           |`                  | Logical OR operator. Returns `true` if one or both operands are true.                                       |
| `!`                                    | Logical NOT operator. Negates the value of the operand. Returns `true` if the operand is false.                           |

### Example

```hcl
resource "random_password" "password-genrator" {
  length = var.length
}

output password {
  value = random_password.password-generator.result
}

# Variables

variable length {
  type = number
  description = "The length of the password"
}


```

## Terraform Workspaces (OSS)
- Terraform offers a feature that allows configuration files within a directory to be reused multiple times for different use cases such as creating a ProjectA and a ProjectB environment within the same configuration directory, to create multiple infrastructure environments.
- To create a workspace, we use the terraform workspace command. this is followed by the new subcommand and the name of the workspace that we want to create.
- `terraform workspace new projectA`