pipeline {
     agent any
     triggers {
          pollSCM('* * * * *')
     }
     stages {
          stage("Compile") {
               steps {
                    sh "./gradlew compileJava"
               }
          }
          stage("Unit test") {
               steps {
                    sh "./gradlew test"
               }
          }
          stage("Code coverage") {
               steps {
                    sh "./gradlew jacocoTestReport"
                    sh "./gradlew jacocoTestCoverageVerification"
               }
          }
          stage("Static code analysis") {
               steps {
                    sh "./gradlew checkstyleMain"
               }
          }
          stage("Package") {
               steps {
                    sh "./gradlew build"
               }
          }

          stage("Docker build") {
               steps {
                    sh "docker build -t leszko/calculator:${BUILD_TIMESTAMP} ."
               }
          }

          stage("Docker login") {
               steps {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'docker-hub-credentials',
                               usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
                         sh "docker login --username $USERNAME --password $PASSWORD"
                    }
               }
          }

          stage("Docker push") {
               steps {
                    sh "docker push leszko/calculator:${BUILD_TIMESTAMP}"
               }
          }
          
          stage("Deploy to staging") {
               steps {
                    sh "kubectl config use-context staging"
                    sh "kubectl apply -f hazelcast.yaml"
                    sh "sed  's/{{VERSION}}/${BUILD_TIMESTAMP}/g' calculator.yaml | kubectl apply -f -"
               }
          }

          stage("Acceptance test") {
               steps {
                    sleep 60
                    sh 'export NODE_IP=$(kubectl get nodes -o jsonpath=\'{ $.items[0].status.addresses[?(@.type=="ExternalIP")].address }\')'
                    sh 'export NODE_PORT=$(kubectl get svc calculator-service -o=jsonpath=\'{.spec.ports[0].nodePort}\')'
                    sh './gradlew acceptanceTest -Dcalculator.url=http://$NODE_IP:$NODE_PORT'
               }
          }

          stage("Release") {
               steps {
                    sh "kubectl config use-context production"
                    sh "kubectl apply -f hazelcast.yaml"
                    sh "sed  's/{{VERSION}}/${BUILD_TIMESTAMP}/g' calculator.yaml | kubectl apply -f -"
               }
          }
          stage("Smoke test") {
              steps {
                  sleep 60
                  sh "./smoke_test.sh"
              }
          }
     }
}