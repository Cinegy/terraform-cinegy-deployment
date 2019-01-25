Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Install-Module -name sqlserver -Force -SkipPublisherCheck -Confirm:$False

#Invoke-SqlCmd -Query "CREATE DATABASE ${archive_db_name}" -ServerInstance ${mssql_address} -Username ${rds_sa_username} -Password ${rds_sa_password}

Invoke-SqlCmd -Query "CREATE LOGIN [AWSADDEV\Cinegy_Archive_MAM_Admins] FROM WINDOWS"  -ServerInstance ${mssql_address} -Username ${rds_sa_username} -Password ${rds_sa_password} -Database ${archive_db_name}

Invoke-SqlCmd -Query "CREATE USER [AWSADDEV\Cinegy_Archive_MAM_Admins] FOR LOGIN [AWSADDEV\Cinegy_Archive_MAM_Admins]"  -ServerInstance ${mssql_address} -Username ${rds_sa_username} -Password ${rds_sa_password} -Database ${archive_db_name}

Invoke-SqlCmd -Query "exec msdb.dbo.rds_restore_database 
        @restore_db_name='archive_dev_auto', 
        @s3_arn_to_restore_from='arn:aws:s3:::cinegyexample-terraform-state-1234/dev/sqlbackups/archive-dev-auto.bak'" -ServerInstance ${mssql_address} -Username ${rds_sa_username} -Password ${rds_sa_password} 

Invoke-SqlCmd -Query "ALTER ROLE [mam_Admin] ADD MEMBER [AWSADDEV\Cinegy_Archive_MAM_Admins]" -ServerInstance ${mssql_address} -Username ${rds_sa_username} -Password ${rds_sa_password} -Database ${archive_db_name}
