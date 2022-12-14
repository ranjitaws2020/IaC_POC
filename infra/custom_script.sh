sudo apt update

sudo docker --version

sudo docker pull jenkins/jenkins:lts-jdk11

sudo docker run -d --name jenkins -p 8080:8080 jenkins/jenkins:lts-jdk11

sudo docker pull sonarqube:lts-community

sudo docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community

sudo docker pull sonatype/nexus3

sudo docker run -d --name nexus -p 8081:8081 sonatype/nexus3