def call(login)
{
//bat label: '', script: """E:\\Devops\\apache-maven-3.8.6\\bin\\mvn.cmd clean verify sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.login=${login}"""
  bat label: '', script: """C:\\Ranjit\\Code Samples\\apache-maven-3.9.1\\bin\\mvn.cmd clean verify sonar:sonar -Dsonar.host.url=http://localhost:9000 -Dsonar.login=${login}"""
}
