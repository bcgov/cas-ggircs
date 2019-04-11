pipeline {
    agent none

    stages {
        stage('Build') {
            agent any
            steps {
                sh 'make -v'
                sh 'perl -v'
                sh 'perl -MCPAN -e "install App::Sqitch DBD::Pg"'
            }
        }
    }
}
