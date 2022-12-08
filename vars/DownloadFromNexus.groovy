def call()
{
  withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexus-ID', passwordVariable: 'pw', usernameVariable: 'user']]) {
    bat(script: 'curl -L -XGET "http://localhost:8081/service/rest/v1/search/assets/download?sort=version&repository=maven-snapshots&maven.groupId=com.javawebtutor&maven.artifactId=LoginWebApp&maven.extension=war" --output LoginWebApp.war -u %user%:%pw%')
  }
}
