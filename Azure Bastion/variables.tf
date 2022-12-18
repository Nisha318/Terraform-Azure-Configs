variable "number_of_subnets" {
  type=number
  description="This defines the number of subnets"
  default =2
  validation {
    condition = var.number_of_subnets < 5
    error_message = "The number of subnets must be less than 5."
  }
}

variable "number_of_machines" {
  type=number
  description="This defines the number of virtual machines"
  default=2
}