def CONTAINER_NAME="alpine-tcat"
def DOCKER_HUB_USER="babu479"
def CONTAINER_TAG="latest"

node('') {
stage ('Initialize') {
        def mavenHome  = tool 'maven'
        env.PATH = "${mavenHome}/bin:${env.PATH}"
}

stage ('Checkout') {
git branch: 'master',
credentialsId: 'a50ea8b8-f277-4ee1-81d4-cf477de0a88d',
url: 'https://gitlab.com/fluidjeel/sample-java-maven.git'
}
stage ('Build') {
sh "mvn clean package"
}

stage ('Removing Running Containers'){
sh "./dockerkill.sh"
}

stage('Image Build'){
        imageBuild(CONTAINER_NAME, CONTAINER_TAG)
    }
    stage('Push to Docker Registry'){
        withCredentials([usernamePassword(credentialsId: 'DockerHubAccount', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
            pushToImage(CONTAINER_NAME, CONTAINER_TAG, USERNAME, PASSWORD)
        }
    }
	stage('Running in Container'){
	containerRun(CONTAINER_NAME,CONTAINER_TAG)
}
}
def imageBuild(containerName, tag){
    sh "cp $WORKSPACE/target/*.war $WORKSPACE"
    sh "./imageBuild.sh $containerName"
    echo "Image build complete"
}

def pushToImage(containerName, tag, dockerUser, dockerPassword){
    sh "./pushToImage.sh $containerName $dockerUser $dockerPassword"
    echo "Image push complete"
	}
def containerRun(containerName,tag){
   sh "./containerRun.sh $containerName"
   }

