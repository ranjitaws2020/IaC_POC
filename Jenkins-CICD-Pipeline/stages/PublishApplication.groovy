def call()
{
  bat 'dotnet publish --configuration Release --output .\\bin\\Publish'
  bat 'del .\\bin\\Publish\\*.pdb'
}
