pipeline {
    agent none

    stages {
        stage('Build') {
            agent any
            steps {
                sh 'make -v'
                sh 'perl -v'
                sh 'which -a perl'
                sh 'ls -la /usr/bin'
                sh 'ls -la /bin'
                sh 'cpan -v'
            }
        }
    }
}
