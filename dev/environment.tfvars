#this must be the name of the containing folder - this gets used for calculation further down!
environment_name="dev"

#these values are used when locking to the remote state bucket when sharing outputs between modules
state_bucket = "cinegyexample-terraform-state-1234"
state_region = "eu-west-1"
aws_region = "eu-west-1"

#this is the pre-created zoneid in route53 that can be used for convienence DNS entries (e.g. sysadmin box access)
shared_route53_zone_id = "ABCDEFG"
shared_route53_zone_suffix = "terraform.cinegy.net"

#ad preferences and params
domain_name = "awsaddev.cinegy.net"
domain_default_computer_ou = "OU=computers,OU=awsaddev,DC=awsad,DC=cinegy,DC=net"

#secrets held outside of source control to inject into resources
aws_secrets_privatekey_arn = "arn:aws:secretsmanager:eu-west-1:1234:secret:terraform-cinegyexample-deployment/dev/privatekey.pem-hNy80m"
aws_secrets_domain_admin_password_arn = "arn:aws:secretsmanager:eu-west-1:1234:secret:terraform-cinegyexample-deployment/dev/domain-admin-password-332DG5"
aws_secrets_generic_account_password_arn = "arn:aws:secretsmanager:eu-west-1:1234:secret:terraform-cinegyexample-deployment/dev/domain-admin-password-332DG5"