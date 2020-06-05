resource "null_resource" "build" {
  count    = var.build_command != "" ? 1 : 0
  triggers = var.build_triggers

  provisioner "local-exec" {
    command = var.build_command
  }
}

variable "build_command" {
  type    = string
  default = ""
}

variable "build_triggers" {
  description = "A map of values which should cause the build command to re-run. Values are meant to be interpolated references to variables or attributes of other resources."
  type        = map
  default     = {}
}
