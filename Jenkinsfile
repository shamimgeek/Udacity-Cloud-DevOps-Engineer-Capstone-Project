pipeline {
    
    agent any

    environment {
        // registry credentials
        registryCredentials = 'dockerhubCredentials'

    }

    stages {
        // Linting
        stage('Linting') {
            steps {
                script {
                    docker.image('hadolint/hadolint:latest-debian').inside() {
                            sh 'hadolint ./Dockerfile | tee -a hadolint_lint.txt'
                            sh '''
                                lintErrors=$(stat --printf="%s"  hadolint_lint.txt)
                                if [ "$lintErrors" -gt "0" ]; then
                                    echo "Errors have been found, please see below"
                                    cat hadolint_lint.txt
                                    exit 1
                                else
                                    echo "There are no erros found on Dockerfile!!"
                                fi
                            '''
                    }
                }
            }
        }

        // Build Docker image
        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build("shamim009/hello-world:${env.BRANCH_NAME}")
                }
            }
        }

        // Scan Docker Image vulnerability with Anchore inline scan
        stage('Scan Image') {
            steps {
                sh "curl -s https://ci-tools.anchore.io/inline_scan-latest | bash -s -- -p -r shamim009/hello-world:${env.BRANCH_NAME}"
            }
        }

        // Publish Docker image to docker hub registry
        stage('Publish Image') {
            steps {
                script {
                    dockerImage = docker.build("shamim009/hello-world:${env.BRANCH_NAME}")
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }

        // Deploy app to AWS EKS if it is tag
        stage('Deploy') {
            steps {
                dir('k8s') {
                    withAWS(credentials: 'aws-credentials', region: 'eu-west-1') {
                        sh "aws eks --region ap-southeast-2 update-kubeconfig --name CapstoneEKSDev-EKS-CLUSTER"
                        sh 'kubectl apply -f hello-world.yaml'
                    }
                }
            }
        }

        // Test Deployment
        stage('Test') {
            steps {
                script {
                    sh 'echo Testing....'
                }
            }
        }
        // Clean
        stage('Clean') {
            steps {
                script {
                    sh "docker rmi shamim009/hello-world:${env.BRANCH_NAME}"
                    sh "docker system prune -f"
                }
            }
        }
    }
}