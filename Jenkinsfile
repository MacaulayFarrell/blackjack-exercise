pipeline{
    agent any
    environment {
        app_version = 'v1'
        rollback = 'false'
    }
    stages {
        stage('Set up') {
            steps {
                //this may not be required, depends if we need a test vm
 //               load "/home/jenkins/.envvars/env-vars.groovy"
                sh '''
                ssh $USER@$VM <<EOF
                if [ -d "blackjack-exercise" ]
                then
                rm -r blackjack-exercise --force
                git clone https://github.com/keenan218/blackjack-exercise.git
                else
                git clone https://github.com/keenan218/blackjack-exercise.git
                fi
                >>EOF
                '''
            }
        }
/*        stage('Build images') {
            steps{
                script {
                    if (env.rollback == 'false') {
                        image = docker.build("maccpr7/frontend-react", "./frontend")
                        image1 = docker.build("maccpr7/backend-java", "./backend")
                    }
                }
            }
        }
        stage ('Push images') {
            steps{
                script {
                    if (env.rollback == 'false'){
                        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials'){ //need to set up a dockerhub credentials on jenkins
                            image.push("${env.app_version}")
                            image1.push("${env.app_version}")
                        }
                    }                 
                }
            }
        } */
        stage('Deploy app') {
            steps { 
                sh '''
                ssh $USER@$VM <<EOF
                
                sudo apt update
                curl https://get.docker.com | sudo bash
                sudo curl -L "https://github.com/docker/compose/releases/download/1.25.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
                sudo chmod +x /usr/local/bin/docker-compose
                sudo usermod -aG docker $(whoami)
                newgrp docker
                
                cd blackjack-exercise
                export app_version = $app_version
                docker-compose up -d --build 
                >> EOF
                '''
            }
        }
/*        stage('Production deploy') {
            steps {
              //  load "/home/jenkins/.envvars/env-vars-prod.groovy"
                sh '''
                kubectl apply -f /kubernetes
                '''
            }

        }*/
    }
}
