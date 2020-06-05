module "test" {
  source              = "../."
  name                = "test"
  compatible_runtimes = ["ruby2.7"]
  source_dir          = "ruby"
}

output "excluded_files" {
  value = module.test.excluded_files
}
