Import-Module ActiveDirectory

$secretValue = Get-SECSecretValue -AccessKey ${aws_access_key} -SecretKey ${aws_secret_access_key} -SessionToken ${aws_session} -SecretId ${domain_admin_account_password_secret_arn}
$SecureStringPassword = ConvertTo-SecureString -AsPlainText $secretValue.SecretString -Force

$MySecureCreds = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ${domain_admin_account_username},$SecureStringPassword

#note - this seems to trigger an exception about permissions - probably some keberos double-hop issue related to our inability to directly address AWS DC
#however, the record gets made so i don't care...
$session = New-PSSession -computerName localhost -credential $MySecureCreds

Invoke-Command -Session $session -Scriptblock {Add-DnsServerResourceRecordCName -Name '${aws_db_instance_identifier}' -HostNameAlias '${aws_db_instance_address}' -ZoneName '${domain_name}' -ComputerName '${domain_name}'}

Remove-PSSession $session