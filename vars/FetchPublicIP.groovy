def call()
{
powershell label: '', script: """
az login --service-principal -u $azcon_CLIENT_ID -p $azcon_CLIENT_SECRET -t $azcon_TENANT_ID
az vm list-ip-addresses --resource-group ranjith --name arti-java-vm > fetchpublicip.json
(Get-Content fetchpublicip.json | ConvertFrom-Json).virtualMachine.network.publicIpAddresses.ipAddress > output.txt
"""
}

//$pubip = Get-Content fetchpublicip.json | ConvertFrom-Json

//echo "$pubip.virtualMachine.network.publicIpAddresses.ipAddress" -OutFile publicip.txt
