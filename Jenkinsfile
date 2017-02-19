pipeline {
     agent any
     stages {
          stage("Build") {
               steps {
                    sh "./gradlew clean compileJava"
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
                }
          }
      }

          post {
              always {
                  junit 'build/reports/**/*.html'
              }
          }
}
