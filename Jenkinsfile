pipeline{
    agent any
    stages{
        stage('checkout'){
            steps{
               git 'https://github.com/kumarrajacse/dockerimage.git'
            }
        }
        stage('Build'){
            steps{
               sh 'mvn clean package'
            }
            post{
                success{
                    echo 'Now Archiving...'
                    archiveArtifacts artifacts: '**/target/*.war'
                }
            }
        }
        stage('SonarQube analysis') {
            steps{
                withSonarQubeEnv('sonar'){
                   sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.6.0.1398:sonar'
                }
            }
			}
        stage ('building docker image'){
          steps
            {
           echo "building the docker image "
           sh 'docker build -t kumarartech/tomcat:2.0 .'
            }
            }
		
		stage('Push the docker image to hub'){
		steps
		{
		echo "login into docker hub "
		withCredentials([usernamePassword(credentialsId: 'docker', passwordVariable: 'passwd', usernameVariable: 'username')]) 
		{
		sh 'docker login -u ${username} -p ${passwd}'
		}
		sh 'docker push kumarartech/tomcat:2.0'
		}
	    }
	stage('Deployment in cluster'){
steps('cluster'){
withKubeConfig(credentialsId: 'kubernetes') {
sh 'kubectl delete -f Deployment.yml '
 sh 'kubectl delete -f Service.yml'
sh 'docker image rmi kumarartech/tomcat:2.0'
sh 'kubectl  apply -f Deployment.yml '
sh 'kubectl  apply -f Service.yml'
	
}
}
}	        
    }
}
