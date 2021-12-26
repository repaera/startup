# PowerUp

All your Rails apps should start off with a bunch of great defaults. It's like Laravel Spark, for Rails.

## Getting Started

Jumpstart is a Rails template, so you pass it in as an option when creating a new app.

#### Requirements

You'll need the following installed to run the template successfully:

* Ruby 2.5 or higher
* bundler - `gem install bundler`
* rails - `gem install rails`
* Database - we recommend Postgres, but you can use MySQL, SQLite3, etc
* Redis - For ActionCable support
* ImageMagick or libvips for ActiveStorage variants
* Yarn - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
* Foreman (optional) - `gem install foreman` - helps run all your processes in development

#### Creating a new app

1. Kickoff

```bash
DISABLE_SPRING=1 rails new [app_name] -d postgresql -m template.rb
```

2. Add-on Devise model (for admin, staff, etc/ control panel side)

```bash
rails generate devise [MODELNAME]
```

3. Generate Devise views for each generated model
```bash
rails generate devise:views [model(s)]
```

4. Generate ActiveAdmin scaffold
```bash
DISABLE_SPRING=1 rails generate active_admin:install
```

5. Populate database credential in `database.yml`
6. Migrate database
7. Downgrade webpack-dev-server into 3.11.2


#### Running your app

Fire up the Postgres and Redis

To run your app, use `foreman start`. Foreman will run `Procfile.dev` via `foreman start -f Procfile.dev` as configured by the `.foreman` file and will launch the development processes `rails server`, `sidekiq`, and `webpack-dev-server` processes.

You can also run them in separate terminals manually if you prefer.

A separate `Procfile` is generated for deploying to production on Heroku.

#### Authenticate with social networks

We use the encrypted Rails Credentials for app_id and app_secrets when it comes to omniauth authentication. Edit them as so:

```
EDITOR=vim rails credentials:edit
```

Make sure your file follow this structure:

```yml
secret_key_base: [your-key]
development:
  github:
    app_id: something
    app_secret: something
    options:
      scope: 'user:email'
      whatever: true
production:
  github:
    app_id: something
    app_secret: something
    options:
      scope: 'user:email'
      whatever: true
```

With the environment, the service and the app_id/app_secret. If this is done correctly, you should see login links
for the services you have added to the encrypted credentials using `EDITOR=vim rails credentials:edit`

This will install Madmin and generate resources for each of the models it finds.
#### Redis set up
##### On OSX
```
brew update
brew install redis
brew services start redis
```
##### Ubuntu
```
sudo apt-get install redis-server
``` 

#### Cleaning up

```bash
rails db:drop
spring stop
cd ..
rm -rf myapp
```
