package test

import (
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestTerratestPlan(t *testing.T) {
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
	}

	output, err := terraform.OutputE(t, terraformOptions, "test_policy_id")
	if err != nil {
		t.Logf("Error getting test_policy_id: %v", err)
	}
	t.Logf("Policy ID: %s", output)
	policyID := "arn:aws:iam::299413808364:policy/test-policy"
	assert.Equal(t, output, policyID)
}
