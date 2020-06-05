package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/require"
)

func TestTerraformLambdaLayer(t *testing.T) {
	t.Parallel()
	awsRegion := aws.GetRandomStableRegion(t, []string{"us-east-1", "eu-west-1"}, nil)

	terraformOptions := &terraform.Options{
		TerraformDir: "examples",

		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}

	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	excludedFiles := terraform.OutputList(t, terraformOptions, "excluded_files")
	require.Equal(t, 4, len(excludedFiles))
}
