pipeline {
     agent any
     stages {
          stage("Build") {
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
          sh "./gradlew jacocoTestCoverageVerification"
     }
}

      }
}

