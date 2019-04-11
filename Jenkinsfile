pipeline {
    agent none

    stages {
        stage('Build') {
            agent any
            steps {
                sh 'make -v'
                sh 'perl -v'
                sh 'which -a perl'
                sh 'cpan -v'
            }
        }
    }
}
