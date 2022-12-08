def call(user, passwd)
{
remote = [:]
remote.name = 'azurevm'
remote.user = user
remote.password = passwd
remote.allowAnyHosts = true
remote.host = powershell script: "Get-Content output.txt", returnStdout: true
remote.host = remote.host.trim()
echo remote.host
sshPut remote: remote, from: 'LoginWebApp.war', into: '/opt/tomcat/9_37/webapps'
}
