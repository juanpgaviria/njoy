node {
  checkout scm
  docker.image('postgres:10.6').withRun('-e "POSTGRES_HOST=db"') { container ->
    sh 'while ! psql -U postgres -c "select 1" -d postgres; do sleep 1; done'
    docker.image('ruby:2.6.0').inside("--link ${container.id}:db") {
      stage('Prepare Container') {
        sh 'wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add -'
        sh 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
        sh 'apt update -qq'
        sh 'apt install -y curl'
        sh 'curl -sL https://deb.nodesource.com/setup_10.x | bash -'
        sh 'apt install -y nodejs postgresql-client'
        sh 'apt install -y qt5-default'
        sh 'apt install -y libqt5webkit5-dev'
        sh 'apt -y install google-chrome-stable'
      }

      stage('Install Gems') {
        sh 'gem install bundler'
        sh 'bundle install'
      }

      stage('Database setup') {
        withEnv(['POSTGRES_HOST=db']) {
          sh 'bundle exec rails db:create'
          sh 'bundle exec rails db:migrate'
        }
      }

      stage('Test') {
        withEnv(['POSTGRES_HOST=db']) {
          sh 'bundle exec rspec'
        }
      }

      stage('Code styling') {
        sh 'bundle exec rubocop'
      }

      stage('Segurity scan') {
        sh 'bundle exec brakeman -o brakeman-output.tabs --no-progress --separate-models'
      }
    }
  }
}
