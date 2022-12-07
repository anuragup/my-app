pipeline {
    agent {label 'mac'}
   
    stages {
        stage ('CheckOut') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/anuragup/my-app.git'

              
            }
        }
        stage ('CodeCheck') {
            steps {
                // Check coding style standard , we can add more findbugs and pmd as well
                sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn checkstyle:checkstyle"
            }
            
        }
        stage ('Build') {
            steps {
                // Build Code
                sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn -Dmaven.test.skip=true install"
            }
            post {
                success {
                    junit 'target/reports/**/*.xml' 
                }
            }
        }
        stage ('Tests') {
            steps {
                // Run Tests
                sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn test -Dmaven.test.failure.ignore=false"
            }
        }
        stage ('SonarScan') {
            steps {
                withSonarQubeEnv(installationName: 'sonarqube'){
                sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0:sonar'
                }
                
            }
        stage ('QualityGate'){
         steps{
             
            timeout(time: 2,unit: 'MINUTES') {
                
            waitForQualityGate abortPipeline: true
            }
         }
        stage ('Deploy'){
         steps{
             
            sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn deploy"
         }
            
         }
        
       }
     }
  }
}
