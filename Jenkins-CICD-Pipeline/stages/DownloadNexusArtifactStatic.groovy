def call()
{
   withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexus-user', passwordVariable: 'pw', usernameVariable: 'user']]) {
                    bat(script: 'curl -L -XGET "http://localhost:8081/repository/dotnet-repo/FileOperation%2F1.0.0" --output FileOperation.nupkg -u %user%:%pw%')
                  }
}
