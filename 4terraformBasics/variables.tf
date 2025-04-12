## Update this file rather than the main file

variable "filename" {
  default = "/root/test.txt"
}

variable "content" {
  default = "Hello World"
  type = string
  description = "the content of the file"
}

variable "prefix" {
  default = ["Mr", "Mrs", "Sir"]
  type = list(string)
}

variable "separator" {
  default = "."
}

variable "length" {
  default = "1"
  type = number
}

variable "file-content" {
  # type = map
  type = map(string)
  default = {
    "statement1" = "We love pets!"
    "statement2" = "We love animals!"
  }
}

variable "jerry" {
  type = object({
    name = string
    color = string
    age = number
    food = list(string)
    favourite_pet = bool
  })


  default = {
    name          = "Jerry"
    age           = 5
    color         = "purple"
    food = ["cheese", "bread", "nuts"]
    favourite_pet = true
  }
}

variable kitty {
  type = tuple([string, number, bool])
  default = ["cat", 2, true]

}

variable "fruit" {
  default = ["apple", "banana", "orange", "strawberry"]
  type = set(string)
}

variable "ami" {
  default = "ami-005e54dee72cc1d00"
}

variable "instance_type" {
  default = "t2.micro"
}