def call()
{
  bat label: '', script: """
  set ARM_CLIENT_ID=$azcon_CLIENT_ID
  set ARM_CLIENT_SECRET=$azcon_CLIENT_SECRET
  set ARM_SUBSCRIPTION_ID=$azcon_SUBSCRIPTION_ID
  set ARM_TENANT_ID=$azcon_TENANT_ID
  terraform -chdir=infra destroy --auto-approve   
  """
}
