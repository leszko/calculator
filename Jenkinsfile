pipeline {
     agent any
triggers {
     pollSCM('* * * * *')
}
     stages {
          stage("Compile") {
               steps {
                   sh "./acceptance_test.sh"
               }
          }






      }
}

