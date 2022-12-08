def call()
{
powershell  label: '', script: 'Copy-Item "target/LoginWebApp.war" "E:\Devops\apache-tomcat-9.0.27\apache-tomcat-9.0.27\webapps" -Force -Verbose'
}
