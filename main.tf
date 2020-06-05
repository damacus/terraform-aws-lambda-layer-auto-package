resource "aws_lambda_layer_version" "this" {
  filename            = data.archive_file.layer.output_path
  layer_name          = var.name
  compatible_runtimes = var.compatible_runtimes
  description         = data.archive_file.layer.output_sha
}

output "layer_version" {
  value = aws_lambda_layer_version.this
}

data "archive_file" "layer" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = var.output_path
  excludes    = local.excluded_files
}

output "archive" {
  value = data.archive_file.layer
}

variable "name" {
  type        = string
  description = "Layer name."
}

variable "source_dir" {
  type        = string
  description = "Source directory for the zip."
}

variable "output_path" {
  type        = string
  description = "Location of the zip."
  default     = "layer.zip"
}

variable "compatible_runtimes" {
  description = "(Optional) A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified."
  type        = list(string)
}

variable "exclude_from_archive" {
  description = "(Optional) A list of files to exclude from the archive."
  type        = list(string)
  default     = []
}

variable "layer_type" {
  description = "Used to set sensible defaults to ignore from the archive package."
  type        = string
  default     = "ruby"
}

locals {
  excluded_files = length(var.exclude_from_archive) == 0 ? local.exclude_from_archive[var.layer_type] : var.exclude_from_archive

  default_excludes = ["README.md"]

  exclude_from_archive = {
    ruby = concat(local.default_excludes, ["Gemfile", "Gemfile.lock", "2.7.0"])
  }
}

output "excluded_files" {
  value = local.excluded_files
}
