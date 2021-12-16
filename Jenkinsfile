pipeline { 
     agent any 
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
                                   allowMissing: false,
      alwaysLinkToLastBuild: false,
      keepAll: true,
               reportDir: 'build/reports/jacoco/test/html', 
               reportFiles: 'index.html', 
               reportName: "JaCoCo Report" 
          ])
                    sh "./gradlew jacocoTestCoverageVerification" 
               } 
          } 
     } 
} 
