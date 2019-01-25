Import-Module ActiveDirectory

$secretValue = Get-SECSecretValue -AccessKey ${aws_access_key} -SecretKey ${aws_secret_access_key} -SessionToken ${aws_session} -SecretId ${domain_test_setup_account_password_secret_arn}

$SecureStringPassword = ConvertTo-SecureString -AsPlainText $secretValue.SecretString -Force

$MySecureCreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ${domain_test_setup_account_username},$SecureStringPassword

$group_ou = New-ADOrganizationalUnit -Name "CinegyGroups" -Path "${cinegy_group_ou_path}" -PassThru -Credential $MySecureCreds

$mam_admin_group = New-ADGroup -Name "Cinegy_Archive_MAM_Admins" -Path $group_ou -PassThru -SamAccountName Cinegy_Archive_MAM_Admins -GroupCategory Security -GroupScope Global -DisplayName "Cinegy Archive MAM Admins" -Description "Members of this group administrators in the Cinegy Archive database" -Credential $MySecureCreds

$testPassword = (ConvertTo-SecureString "${generic_account_password}" -AsPlainText -force) 

foreach ($num in 1..10){
    $new_user = New-ADUser -Name "Bob Test-$num" -GivenName "Bob" -Surname "Test-$num" -SamAccountName "test$num" -AccountPassword $testPassword -Enabled $true -Credential $MySecureCreds -PassThru

    Add-ADGroupMember -Identity $mam_admin_group -Members $new_user -Credential $MySecureCreds
}



