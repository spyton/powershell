# find the interface
Get-NetIpinterface 


# Set the IP informaiton 
New-NetIPAddress -AddressFamily IPV4 -IPAddress 10.10.10.10 -PrefixLength 24 -InterfaceAlias Ethernet


# Set the DNS Servers 
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses "10.10.10.10","10.10.10.11"


# Set the default route 
New-Netroute -DestinationPrefix "0.0.0.0/0" -NextHop "10.10.10.1" -InterfaceAlias Ethernet

