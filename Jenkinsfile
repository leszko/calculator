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
          publishHTML (target: [
               reportDir: 'build/reports/jacoco/test/html',
               reportFiles: 'index.html',
               reportName: "JaCoCo Report"
          ])
          sh "./gradlew jacocoTestCoverageVerification"
     }
}
stage("Static code analysis") {
     steps {
          sh "./gradlew checkstyleMain"
publishHTML (target: [
     reportDir: 'build/reports/checkstyle/',
     reportFiles: 'main.html',
     reportName: "Checkstyle Report"
])
     }
}

stage("Build") {
steps {
sh "./gradlew build"
}
}

stage("Docker build") {
steps {
sh "docker build -t leszko/calculator ."
}
}

stage("Docker login") {
      steps {
   withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'leszko',
                    usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
   sh "docker login --username $USERNAME --password $PASSWORD"
     }
}
}

stage("Docker push") {
      steps {
            sh "docker push leszko/calculator"
     }
}

stage("Deploy to staging") {
     steps {
          sh "docker run -d --rm -p 8765:8080 --name calculator leszko/calculator"
          sleep 120
     }
}

stage("Acceptance tests") {
    steps {
      sh "test `curl localhost:8765/sum?a=1\\&b=2` = 3"
    }
}







      }
}

