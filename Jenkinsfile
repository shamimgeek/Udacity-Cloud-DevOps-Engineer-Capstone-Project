pipeline {
    
    agent any

    environment {
        // registry credentials
        registryCredentials = 'dockerhubCredentials'

    }

    stages {
        // Linting Dockerfile
        stage('Linting Dockerfile') {
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
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("shamim009/hello-world:${env.BUILD_NUMBER}")
                }
            }
        }

        // Scan Docker Image vulnerability with Anchore inline scan
        stage('Scan Docker Image') {
            steps {
                sh "curl -s https://ci-tools.anchore.io/inline_scan-latest | bash -s -- -p -r shamim009/hello-world:${env.BUILD_NUMBER}"
            }
        }

        // Publish Docker image to docker hub registry
        stage('Push Image to Registry') {
            steps {
                script {
                    dockerImage = docker.build("shamim009/hello-world:${env.BUILD_NUMBER}")
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }

        // Deploy app to AWS EKS
        stage('Deploy to EKS Cluster') {
            steps {
                dir('k8s') {
                    withAWS(credentials: 'aws-credentials', region: 'ap-southeast-2') {
                        sh "aws eks --region ap-southeast-2 update-kubeconfig --name CapstoneEKSDev-EKS-CLUSTER"
                        sh "kubectl apply -f hello-world.yaml"
                        sh "kubectl wait --for=condition=available --timeout=300s --all deployments"
                    }
                }
            }
        }

        // Rolling update
        stage('Rolling Update') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'ap-southeast-2') {
                    sh "aws eks --region ap-southeast-2 update-kubeconfig --name CapstoneEKSDev-EKS-CLUSTER"
                    sh "kubectl set env deployment/hello-world APP_COLOR=green BUILD_NUMBER=${env.BUILD_NUMBER}"
                    sh "kubectl set image deployment/hello-world hello-world=shamim009/hello-world:${env.BUILD_NUMBER} --record"
                }
            }
        }
        // Wait for Successfull Rolling update
        stage('Wait for Successfull Rolling Update') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'ap-southeast-2') {
                    sh "aws eks --region ap-southeast-2 update-kubeconfig --name CapstoneEKSDev-EKS-CLUSTER"
                    sh "kubectl wait --for=condition=available --timeout=180s --all deployments"
                    sh "sleep 180"
                }
            }
        }

        // Test Deployment
        stage('Post Deployment Test') {
            steps {
                withAWS(credentials: 'aws-credentials', region: 'ap-southeast-2') {
                    sh '''#!/bin/bash
                        aws eks --region ap-southeast-2 update-kubeconfig --name CapstoneEKSDev-EKS-CLUSTER
                        APP_URL=$(kubectl get service hello-world | grep 'amazonaws.com' | awk '{print $4}')
                        OUTPUT=$(curl --silent ${APP_URL})
                        STATUS_CODE=$(curl -o /dev/null --silent -w "%{http_code}\n" ${APP_URL})

                        # Test Case: 1 Check Status code

                        if [ $STATUS_CODE -eq 200 ]; then
                            echo "Test Case1: Check Status Code: OK"
                        else 
                            echo "Deployment failed"
                            exit 1
                        fi

                        # Test Case: 2 Check if output contains build number
                        if echo ${OUTPUT} |grep -q ${BUILD_NUMBER}; then
                            echo "Test Case2: Check Build Number: OK"
                        else 
                            echo "Deployment failed"
                            exit 1
                        fi
                    '''
                }
            }
        }
        // Clean
        stage('Clean') {
            steps {
                script {
                    sh "docker rmi shamim009/hello-world:${env.BUILD_NUMBER}"
                    sh "docker system prune -f"
                }
            }
        }
    }
}