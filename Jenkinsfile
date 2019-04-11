pipeline {
    agent none

    stages {
        stage('Build') {
            agent {
                docker { image 'sqitch/sqitch' }
            }
            steps {
                sh 'make -v'
                sh 'perl -v'
                sh 'which -a perl'
                sh 'cpan -v'
            }
        }
    }
}
