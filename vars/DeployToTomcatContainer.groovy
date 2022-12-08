def call(user, passwd)
{
ip = powershell label:'', script: 'Get-Content output.txt', returnStdout: true
remote = [:]
remote.name = 'azurevm'
remote.user = user
remote.password = passwd
remote.allowAnyHosts = true
remote.host = ip
remote.host = remote.host.trim()
password = "Arti@123456"
sshCommand remote: remote, command: "mkdir -p /temp"
sshCommand remote: remote, command: "sudo chmod -R 777 /temp"
sshPut remote: remote, from: 'docker-compose.yml', into: '/temp'
sshCommand remote: remote, command: "sudo docker pull doc67/javasampletomcat:latest"
sshCommand remote: remote, command: "cd /temp && sudo docker-compose up -d"
sshCommand remote: remote, command: "sudo rm -rf /temp/*"
}
