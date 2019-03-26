#this must be the name of the containing folder - this gets used for calculation further down!
app_name="Cinegy-Demo"
environment_name="dev"

#these values are used when locking to the remote state bucket when sharing outputs between modules
aws_account_id = "824173187332"
dynamodb_table = "cinegydemo-terragrunt-lock-table"
state_bucket = "cinegydemo-terraform-state-824173187332"
state_region = "eu-west-1"
aws_region = "eu-west-1"

#this is the pre-created zoneid in route53 that can be used for convienence DNS entries (e.g. sysadmin box access)
shared_route53_zone_id = "Z32603TW2B8YE4"
shared_route53_zone_suffix = "terraform.demo.cinegy.net"

#ad preferences and params
domain_name = "awsaddev.demo.cinegy.net"
domain_default_computer_ou = "OU=computers,OU=awsaddev,DC=awsad,DC=demo,DC=cinegy,DC=net"

#secrets held outside of source control to inject into resources
aws_secrets_privatekey_arn = "arn:aws:secretsmanager:eu-west-1:824173187332:secret:terraform-cinegydemo-deployment/dev/privatekey.pem-FZHZeU"
aws_secrets_domain_admin_password_arn = "arn:aws:secretsmanager:eu-west-1:824173187332:secret:terraform-cinegydemo-deployment/dev/generic-password-oA8QC4"
aws_secrets_generic_account_password_arn = "arn:aws:secretsmanager:eu-west-1:824173187332:secret:terraform-cinegydemo-deployment/dev/generic-password-oA8QC4"