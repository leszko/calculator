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
                    publishHTML (target: [
                        reportDir: 'build/reports/jacoco/test/html',
                        reportFiles: 'index.html',
                        reportName: "JaCoCo Report"
                      ])
                    sh "./gradlew jacocoTestCoverageVerification"
                }
          }
      }
}
