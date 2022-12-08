def call()
{
bat label: '', script: 'java --version'
bat label: '', script: 'H:\apache-maven-3.8.6-bin\apache-maven-3.8.6\bin\mvn.cmd clean package'
}
