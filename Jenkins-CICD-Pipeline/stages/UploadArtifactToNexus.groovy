def call()
{
   bat 'dotnet pack .\\UploadandDownloadFiles\\UploadandDownloadFiles.csproj'
   bat 'dotnet nuget push .\\UploadandDownloadFiles\\bin\\Debug\\FileOperation.1.0.0.nupkg -k 2bcfcfe0-5b00-38e1-9086-b9e67205f16d -s http://localhost:8081/repository/dotnet-repo/'
}
