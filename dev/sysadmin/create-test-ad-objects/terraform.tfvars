terragrunt = {
  include {
    path = "${get_tfvars_dir()}/../../../terraform.tfvars"
  }
  dependencies {
    paths = ["../../vpc","../../directoryservice","../../sysadmin"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//runpowershell?ref=v0.0.1"
  
    #this script expects to have AWS session tokens passed
    #DO NOT USE THIS WITHOUT SOMETHING LIKE AWS-VAULT CYCLING SESSIONS
    #or a permanent secret key might end up stuck in some CI logs...
    extra_arguments "aws_session" {
      commands = [
        "apply",
        "plan",
        "push",
        "refresh",
        "destroy"
      ]

      arguments = [
        "-var", "aws_access_key=${get_env("AWS_ACCESS_KEY_ID","")}",
        "-var", "aws_session=${get_env("AWS_SESSION_TOKEN","")}",
        "-var", "aws_secret_access_key=${get_env("AWS_SECRET_ACCESS_KEY","")}"
      ]
    }
  }
}

vm_name_tag_value = "SYSADMIN1A-DEV"
powershell_script_path = "./scripts/create-users.ps1"

template_vars = {
  domain_test_setup_account_username = "awsaddev\\admin"
  domain_test_setup_account_password_secret_arn = "arn:aws:secretsmanager:eu-west-1:1234:secret:terraform-cinegyexample-deployment/dev/domain-admin-password-332DG5"
  generic_account_password = "password!123456789"
  cinegy_group_ou_path = "OU=awsaddev,DC=awsaddev,DC=cinegy,DC=net"
}
