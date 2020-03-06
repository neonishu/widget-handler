### Prerequisites
  - You should have a linux based machine, that is what `machine` refers to in this document
  - You should have Nodejs version >= 10 installed on your machine
  - You should have ruby version = 2.5.3 installed on your machine
  - Preferably have a ruby version manager like RVM or RBENV
  - You should have Postgresql >= 9.1 installed and running on your machine

### How to setup the app
  - Create to be on safe-side create a superuser role
    - Login to psql shell and run `CREATE ROLE <rolename> LOGIN SUPERUSER PASSWORD '<password-string>';`
  - Use these username and passwords in `config/database.yml` file
  - Clone the repository
  - cd the repo directory in terminal
  - This should create and use the gemset called showoff
  - run `gem install bundler`
  - run `bundle install`
  - run `rails db:create db:migrate`
  - run `rails s`
  - Open browser and visit 'http://localhost:3000'
