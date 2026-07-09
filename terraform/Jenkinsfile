pipeline {

    agent any
 
  
    stages {
 
        stage('Checkout Code') {

            steps {

                echo " Checking out repository..."

                git branch: 'main', url: 'https://github.com/hassan-maher-dev/Intelligent-Infrastructure.git'

            }

        }
 
        stage('Terraform Init') {

            steps {

                echo " Initializing Terraform..."

                sh 'terraform init -reconfigure'

            }

        }
 
        stage('Terraform Plan') {

            steps {

                echo " Creating Terraform plan..."

                sh 'terraform plan -out=tfplan'

            }

        }



       stage('Terraform Apply') {

            steps {

                echo " Applying Terraform..."

                sh 'terraform apply -auto-approve tfplan'

                echo " Infrastructure deployed successfully!"

            }

        }



/*       stage('Terraform Destroy') {

            steps {

                echo " Destroying Terraform infrastructure..."

                sh 'terraform destroy -auto-approve'

                echo " Infrastructure destroyed successfully!"

            }

        }
*/

 }
 
    post {

        always {
            // This will always work in the end to clean the space.
            echo " Cleaning up workspace to save disk space..."
            deleteDir() 
        }

        success {

            echo " Pipeline completed successfully!"

        }

        failure {

            echo " Pipeline failed!"

        }

    }
}
