terragrunt = {
  include {
    path = "${find_in_parent_folders()}"
  }
  dependencies {
    paths = ["../vpc","../directoryservice"]
  } 
  
  terraform {
    source = "git::https://github.com/Cinegy/terraform-cinegy-modules.git//basevm-win-cinagent?ref=v0.0.1"
  }
}

aws_subnet_tier = "Private"
aws_subnet_az = "A"
instance_type = "t3.small"
host_name_prefix = "NAS1A"
host_description = "File Server (NAS) 1A"
agent_extra_packages = "Cinegy-Archive-v11.x, dev`n"
allow_all_internal_traffic = true
attach_data_volume = true
data_volume_size = 60


user_data_script_extension = <<EOF

Get-Disk | Where-Object partitionstyle -eq 'raw' | 
Initialize-Disk -PartitionStyle MBR -PassThru | 
New-Partition -AssignDriveLetter -UseMaximumSize | 
Format-Volume -FileSystem NTFS -NewFileSystemLabel "essence" -Confirm:$false 

New-Item -ItemType directory -Path "D:\Essence"

New-SmbShare -Name "Essence" -Path "D:\Essence" -ChangeAccess "everyone"

RenameHost
EOF

