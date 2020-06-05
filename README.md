# terraform-aws-lambda-layer-auto-package

A terraform module to define a lambda layer which source files are automatically built and packaged for deployment.

## Features

Creates a lambda layer

- Automatically moves Ruby Gems vendor into the correct folder structure

## Usage

```hcl
module "chef-layer" {
  source  = "damacus/lambda-layer-auto-package/aws"

  name                = "Chef"
  compatible_runtimes = ["ruby2.7"]
  layer_type          = "ruby"
  source_dir          = "../layers/chef"
  build_command       = "cd ${path.module}/..; make build_layer"
  build_triggers = {
    requirements = "${base64sha256(file("${path.module}/../app/Gemfile"))}"
  }
}
```
