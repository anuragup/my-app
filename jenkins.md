pipeline {
    agent {label 'mac'}
   
    stages {
        stage ('CheckOut') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/anuragup/my-app.git'

                // Run Maven on a Unix agent.
                //sh "mvn -Dmaven.test.failure.ignore=true clean package"

                // To run Maven on a Windows agent, use
                 //bat "mvn -Dmaven.test.failure.ignore=true clean package"
            }
        }
        stage ('CodeCheck') {
            steps {
                sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn checkstyle:checkstyle"
            }
            
        }
        stage ('Build') {
            steps {
                sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn -Dmaven.test.skip=true install"
            }
            post {
                success {
                    junit 'target/surefire-reports/**/*.xml' 
                }
            }
        }
        stage ('Tests') {
            steps {
                sh "/usr/local/Cellar/maven/3.8.6/libexec/bin/mvn test"
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
