def call()
{
 withSonarQubeEnv('sonarqube-8.9.10') {
                    bat "dotnet tool install --global dotnet-sonarscanner"
                    bat 'dotnet sonarscanner begin /k:\"dotnet_demo\" /d:sonar.host.url="http://localhost:9000"  /d:sonar.login="b4746c5e910a9def9a7dc53815d216e429e62c31"'
                    bat 'dotnet build'
                    bat 'dotnet sonarscanner end /d:sonar.login="b4746c5e910a9def9a7dc53815d216e429e62c31"'
		    
				}
}
