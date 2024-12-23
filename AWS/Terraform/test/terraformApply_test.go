package test

import (
	_ "fmt"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"testing"
)

func TestTerratest(t *testing.T) {
	t.Parallel()
	awsRegion := "ap-northeast-1"
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../AWS/dev/tokyo/",
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	})
	if _, err := terraform.InitE(t, terraformOptions); err != nil {
		t.Errorf("Terraform Init Error: %v", err)
		return
	}
	if _, err := terraform.PlanE(t, terraformOptions); err != nil {
		t.Errorf("Terraform Plan Error: %v", err)
		return
	}
	if _, err := terraform.ApplyE(t, terraformOptions); err != nil {
		t.Errorf("Terraform Apply Error: %v", err)
		terraform.Destroy(t, terraformOptions)
	}

	// output := terraform.Output(t, terraformOptions, "test_policy_id")
	// fmt.Println("Output:\n", output)
}
