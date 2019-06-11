node {
  docker.image('postgres').withRun { container ->
    docker.image('ruby:2.6.0').inside("--link=${container.id}:postgres") {
      stage('Install Dependencies'){
        sh "ruby --version"
        sh "apt-get update"
        sh "apt-get install -y nodejs"
        sh "gem install bundler"
        sh "bundle install"
      }
      stage('Invoke Rake'){
        withEnv(['DATABASE_URL=postgres://postgres@postgres:5432/']) {
          "bundle exec rspec"
        }
        junit 'spec/reports/*.xml'
      }
    }
  }
}
