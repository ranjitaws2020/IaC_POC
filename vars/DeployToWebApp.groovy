def call()
{
powershell label: '', script: """
az login --service-principal -u $azcon_CLIENT_ID -p $azcon_CLIENT_SECRET -t $azcon_TENANT_ID
#az webapp stop --name hexa-java-poc --resource-group javatomcat
az webapp deploy --resource-group javatomcat --name hexa-java-poc --src-path ./LoginWebApp.war
az webapp restart --name hexa-java-poc --resource-group javatomcat
"""
}
