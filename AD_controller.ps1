# install the domain controller 
# As an administrator , open a powershell

# identify the windows Features to install: 
get-windowsFeature | where-object Name -like *domain*
get-windowsFeature | where-object Name -like *dns*

#install the necessary feactures 
Install-windowsFeature AD-domain-services, DNS  -IncludeManagementTools


#Configure the domain
$SMPASS = ConvertTO-SecureString '19881009' -AsPlainText -Force
# newforest
Install-ADDSForest  -DomainName  yang.local -safeModeAdministratorPassword $SMPASS -Confirm:$False



#join a computer to domain 
$sectring=ConvertTO-SecureString '19881009' -AsPlainText -Force

$Mycred=New-object -TypeName PScredential -ArgumentList "yang.local\administrator",$sectring

Add-computer -domainName "yang.local"  -Credential $Mycred -Restart



# promoting the system to a DC : 
Install-windowsFeature -Name AD-domain-services, DNS -IncludeManagementTools -computerName dell

Invoke-command -computerName dell -ScriptBlock {

$secPass = ConvertTO-SecureString ''  -AsPlainText -Force

$Mycred= New-object -TypeName PScredential -ArgumentList "yang.local\administrator",$secPass 

$SMPASS = ConvertTO-SecureString ' ' -AsPlainText -Force

Install-ADDSDomainController  -DomainName yang.local  -safeModeAdministratorPassword $SMPASS -Credential $Mycred -confirm:$false 

}