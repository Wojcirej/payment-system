# Payment system

Based on "Agile software development, principles, patterns, and practices" book.

# Specification
You can find specification in part III of said book. The purpose of this project is to learn to develop application by sticking to specified stories, requirements, and use learned practices (also from this book). Disclaimer: not all mentioned design patterns might have sense in Ruby, neither all must be name
in exactly the same way.

Important - this is backend only. Possibly there will be separate app for frontend, also for learning purposes.

# Technologies
* Ruby 2.5.1
* Rails 5.2.0 API
* Postgresql 10.4
* More to come

# Development setup
```
rake db:create
rake db:schema:load
rake db:seed
```

# Development server
```
rails s
```

# Launch tests
```
rspec
```

# End to end tests
Are moved away from this repository to speed up set of development tests. See [this repo](https://github.com/Wojcirej/payment-system-end-to-end) for more details.

# Deploy
Make sure you have set up properly remotes:
```
git remote add staging https://git.heroku.com/payment-system-backend-stg.git
git remote add production https://git.heroku.com/payment-system-backend.git
```
Then for staging deploy run command:
```
ruby deploy.rb staging
```
Production deploy:
```
ruby deploy.rb production
```
To run migrations just add ```-m``` parameter

# Live-demo
* [Staging](https://payment-system-backend-stg.herokuapp.com/)
* [Production](https://payment-system-backend.herokuapp.com/)
