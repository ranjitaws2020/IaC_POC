pipeline {
    agent any

      environment {
       sonarlogin = credentials('sonarqube-token')
       scannerHome = tool 'sonar-msbuild'
       
       MSBUILD_SQ_SCANNER_HOME = tool name: 'sonar-msbuild', type: 'hudson.plugins.sonar.MsBuildSQRunnerInstallation'
       
        nexuscred = credentials('nexus-user')
       
        NEXUS_VERSION = "nexus3"
        NEXUS_PROTOCOL = "http"
        NEXUS_URL = "localhost:8081"
        NEXUS_REPOSITORY = "dotnet-repo"
        NEXUS_CREDENTIAL_ID = "nexus-user"
       }
      tools {
        
        jdk 'java_jdk'
      }
    stages {
        stage('Checkout Source Code') {
            steps {
                checkout scmGit(branches: [[name: '*/arti-dotnet-webapi']], extensions: [], userRemoteConfigs: [[credentialsId: 'git-java', url: 'https://github.com/ranjitaws2020/IaC_POC.git']])
                
            }
        }
        stage('Dependencies') {
            steps {
                script {
                    bat 'dotnet restore'
                }
            }
        }
        stage('Build'){
            steps {
                script {
                  bat 'dotnet build --configuration Release'
                }
            }
        }
         stage('SonarQube Analysis') {
            steps{
                withSonarQubeEnv('sonarqube-8.9.10') {
                    //bat "dotnet tool install --global dotnet-sonarscanner"
                    bat 'dotnet sonarscanner begin /k:\"dotnet_demo\" /d:sonar.host.url="http://localhost:9000"  /d:sonar.login="b4746c5e910a9def9a7dc53815d216e429e62c31"'
                    bat 'dotnet build'
                    bat 'dotnet sonarscanner end /d:sonar.login="b4746c5e910a9def9a7dc53815d216e429e62c31"'
				}
			}
        }
        stage('Publish') {
            steps {
                script {
                  bat 'dotnet publish --configuration Release --output .\\bin\\Publish'
                  bat 'del .\\bin\\Publish\\*.pdb'
                }
            }
        }
       
        stage('Store war to Nexus') {
            steps{
                bat 'dotnet pack .\\UploadandDownloadFiles\\UploadandDownloadFiles.csproj'
                bat 'dotnet nuget push .\\UploadandDownloadFiles\\bin\\Debug\\FileOperation.1.0.0.nupkg -k 2bcfcfe0-5b00-38e1-9086-b9e67205f16d -s http://localhost:8081/repository/dotnet-repo/'
            }
        }
        stage('Pull the file off Nexus') {
            steps{
               
                  withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'nexus-user', passwordVariable: 'pw', usernameVariable: 'user']]) {
                    bat(script: 'curl -L -XGET "http://localhost:8081/repository/dotnet-repo/FileOperation%2F1.0.0" --output FileOperation.nupkg -u %user%:%pw%')
                  }
                
            }
         }
        stage('Host app to IIS') {
            steps {
               script {
                    
                    try {
                        echo "Stopping App Pool"
                        bat "%systemroot%\\system32\\inetsrv\\appcmd stop apppool /apppool.name:DefaultAppPool"
                    }
                    catch (Exception err) {
                        echo err.getMessage()
                    }
                    
                    echo "Cleaning the app folder"
                    bat "del \"C:\\inetpub\\wwwroot\\UploadDowFilesJenkinsPipeline\\**\" /S /Q"
                    
                    echo "Copying the published files to the app folder"
                    bat "xcopy \"C:\\ProgramData\\Jenkins\\.jenkins\\workspace\\DotNetAPI-CICD\\DotNetAPI_CI\\bin\\publish\\**\" \"C:/inetpub/wwwroot/UploadDowFilesJenkinsPipeline\" /E /Q"
                    
                    echo "Starting App Pool"
                    bat "%systemroot%\\system32\\inetsrv\\appcmd start apppool /apppool.name:DefaultAppPool"
                }
            }
        }
    }
}