# change the network to privte mode
# enable-Psremoting
# set-up the trust networkIP


$domain=Read-Host "Saisir le domaine à rejoindre"
$mdp= Read-Host "Saisir le login mot de passe de l'administrateur du domaine"
$computer = Read-Host "Quel PC (saisir le nom)"
$admin=Read-Host " Nom de l'admin pour ce PC "
$mdp2=Read-Host "Mot de passe pour ce PC "
$reponse= Read-Host "confirmer à rejoindre (O/N)"
 
if($reponse -eq "O") 

{

$mycred=New-Object System.Management.Automation.PSCredential($admin,(ConvertTo-SecureString $mdp2 -AsPlainText -Force))

Invoke-Command -ComputerName $computer -ScriptBlock {

$cred=New-Object System.Management.Automation.PSCredential("$Using:domain\Administrator",(ConvertTo-SecureString $Using:mdp -AsPlainText -Force))
Add-Computer -DomainName $Using:domain -Credential $cred 
} -Credential $mycred


}
