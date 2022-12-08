def call(user, passwd)
{
ip = powershell label:'', script: 'Get-Content output.txt', returnStdout: true
remote = [:]
remote.name = 'azurevm'
remote.user = user
remote.password = passwd
remote.allowAnyHosts = true
remote.host = powershell script: "Get-Content output.txt", returnStdout: true
remote.host = remote.host.trim()
sshCommand remote: remote, command: "sudo mkdir -p /temp && sudo chmod -R 777 /temp"
sshPut remote: remote, from: 'LoginWebApp.war', into: '/temp'
sshPut remote: remote, from: 'dockerfile', into: '/temp'  
sshCommand remote: remote, command: "sudo docker build -t javasampletomcat:latest /temp"
sshCommand remote: remote, command: "sudo docker tag javasampletomcat:latest doc67/javasampletomcat:latest"
sshCommand remote: remote, command: "sudo docker login -u 'doc67' -p 'Arti@123456'"
sshCommand remote: remote, command: "sudo docker push doc67/javasampletomcat:latest"
sshCommand remote: remote, command: "sudo docker image prune -a -f"
sshCommand remote: remote, command: "sudo rm -rf /temp/*"
}
