require "fileutils"
require "shellwords"

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require "tmpdir"
    source_paths.unshift(tempdir = Dir.mktmpdir("startup-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/repaera/startup.git",
      tempdir
    ].map(&:shellescape).join(" ")

    if (branch = __FILE__[%r{startup/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def rails_version
  @rails_version ||= Gem::Version.new(Rails::VERSION::STRING)
end

def rails_5?
  Gem::Requirement.new(">= 5.2.0", "< 6.0.0.beta1").satisfied_by? rails_version
end

def rails_6?
  Gem::Requirement.new(">= 6.0.0.alpha", "< 7").satisfied_by? rails_version
end

def rails_7?
  Gem::Requirement.new(">= 7.0.0.alpha", "< 8").satisfied_by? rails_version
end

def master?
  ARGV.include? "--master"
end

def add_gems
  gem 'bootstrap', '5.0.0'
  if rails_7? || master?
    gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'master'
  else
    gem 'devise', '~> 4.8', '>= 4.8.0'
  end
  gem 'font-awesome-sass', '~> 5.15'
  gem 'friendly_id', '~> 5.4'
  gem 'hotwire-rails'
  gem 'image_processing'
  gem 'name_of_person', '~> 1.1'
  gem 'noticed', '~> 1.2'
  gem 'omniauth-facebook', '~> 8.0'
  gem 'omniauth-github', '~> 2.0'
  gem 'omniauth-twitter', '~> 1.4'
  gem 'pretender', '~> 0.3.4'
  gem 'pundit', '~> 2.1'
  gem 'sidekiq', '~> 6.2'
  gem 'sitemap_generator', '~> 6.1'
  gem 'whenever', require: false
  gem 'responders', github: 'heartcombo/responders'
  gem 'redis', '~> 4.4'
  gem 'meta-tags'
  gem 'ransack'
  gem 'mini_magick', '~> 4.10', '>= 4.10.1'
  gem 'figaro', '~> 1.2'
  gem 'pagy', '~> 3.14'
  gem 'chartkick', '~> 4.0'
  gem 'aws-sdk-s3'
  gem 'sidekiq-scheduler'
  gem 'omniauth-google-oauth2'
  gem 'draper' # https://github.com/drapergem/draper
  gem 'activerecord-import', require: false  # https://github.com/zdennis/activerecord-import#requiring
  gem 'simple_form'  # https://github.com/heartcombo/simple_form
  gem 'cocoon'  # https://github.com/nathanvda/cocoon
  gem 'ice_cube', '~> 0.16.4'  # http://seejohnrun.github.com/ice_cube/
  gem 'cells-rails'  # https://github.com/trailblazer/cells view_component alternative
  gem 'view_component'  # https://viewcomponent.org/guide/getting-started.html
  gem 'breadcrumbs_on_rails'  # https://github.com/weppos/breadcrumbs_on_rails
  gem 'closure_tree' # https://github.com/ClosureTree/closure_tree#installation OR TAGGABLE
  gem 'counter_culture', '~> 2.0'  # https://github.com/magnusvk/counter_culture
  gem 'rails-i18n', '~> 6.0.0'   # https://github.com/svenfuchs/rails-i18n
  gem 'fcm', '~> 1.0', '>= 1.0.3'  # https://github.com/spacialdb/fcm/
  gem 'webpush', '~> 1.1'  # https://github.com/zaru/webpush/
  gem 'redcarpet', '~> 3.5', '>= 3.5.1'  # https://github.com/vmg/redcarpet/
  gem 'activeadmin'  # https://activeadmin.info/documentation.html
  gem 'aasm', '~> 5.2'  # https://github.com/aasm/aasm
  gem 'canonical-rails', github: 'jumph4x/canonical-rails'
  gem 'hashid-rails', '~> 1.4', '>= 1.4.1'  # https://github.com/jcypret/hashid-rails
  gem 'acts_as_tenant', '~> 0.5.1'  # https://github.com/ErwinM/acts_as_tenant
  gem 'acts_as_list', '~> 1.0', '>= 1.0.4'  # http://github.com/brendon/acts_as_list
  gem 'invisible_captcha', '~> 2.0'  # https://github.com/markets/invisible_captcha
  gem 'merit', '~> 4.0', '>= 4.0.2'  # https://github.com/tute/merit
  gem 'dalli', '~> 2.7', '>= 2.7.11'  # https://github.com/petergoldstein/dalli/
  gem 'connection_pool', '~> 2.2', '>= 2.2.5'  # https://github.com/mperham/connection_pool/
  gem 'database_cleaner', '~> 2.0', '>= 2.0.1'  # https://github.com/DatabaseCleaner/database_cleaner/
  gem 'geocoder', '~> 1.6', '>= 1.6.7'  # https://github.com/alexreisner/geocoder/
  gem 'ancestry', '~> 4.1'  # https://github.com/stefankroes/ancestry/
  gem 'unread', '~> 0.11.0'  # https://github.com/ledermann/unread/
  gem 'merit', '~> 4.0', '>= 4.0.2'  # https://github.com/tute/merit/
  gem 'business_time', '~> 0.10.0'  # https://github.com/bokmann/business_time/
  gem 'local_time', '~> 2.1'  # https://github.com/basecamp/local_time/
  gem 'time_diff', '~> 0.3.0'  # https://github.com/abhidsm/time_diff/
  gem 'groupdate', '~> 5.2', '>= 5.2.2'  # https://github.com/ankane/groupdate/
  gem 'auto_html'  # https://github.com/dejan/auto_html
  gem 'rack-protection', '~> 2.1'  # https://github.com/sinatra/sinatra/
  gem 'rack-attack', '~> 6.5'  # https://github.com/rack/rack-attack/
  gem 'turnout', '~> 2.5'  # https://github.com/biola/turnout/
  gem 'split', '~> 3.4', '>= 3.4.1'  # https://github.com/splitrb/split/
  gem 'browser', '~> 5.3', '>= 5.3.1'  # https://github.com/fnando/browser/
  gem 'wicked', '~> 1.3', '>= 1.3.4'  # https://github.com/schneems/wicked/
  gem 'attr_encrypted', '~> 3.1'  # https://github.com/attr-encrypted/attr_encrypted/
  gem 'logging', '~> 2.3'  # https://github.com/TwP/logging/
  gem 'render_async'  # https://github.com/renderedtext/render_async
  gem 'gon', '~> 6.4'  # https://github.com/gazay/gon/
  gem 'rabl-rails', '~> 0.6.0'  # https://github.com/ccocchi/rabl-rails
  gem 'acts-as-taggable-on', '~> 8.1'  # https://github.com/mbleigh/acts-as-taggable-on
  gem 'acts_as_list', '~> 1.0', '>= 1.0.4'  # https://github.com/brendon/acts_as_list
  gem 'acts_as_votable'  # https://github.com/ryanto/acts_as_votable
  gem 'oj'  # https://github.com/ohler55/oj
  gem 'anycable', '~> 1.2'  # https://github.com/anycable/anycable
  gem 'slowpoke'  # https://github.com/ankane/slowpoke
  gem 'lograge'  # https://github.com/roidrage/lograge
  gem 'safely_block'  # https://github.com/ankane/safely
  gem 'enumerize', '~> 2.4'  # https://github.com/brainspec/enumerize/
  gem 'paper_trail'  # https://github.com/paper-trail-gem/paper_trail#1b-installation
  gem 'discard', '~> 1.2'  # https://github.com/jhawthorn/discard
  gem 'valid_email', '~> 0.1.3'  # https://github.com/hallelujah/valid_email/
  gem 'rack-timeout', '~> 0.6.0'  # https://github.com/sharpstone/rack-timeout/
  gem 'rack-timeout-puma', '~> 0.0.1'  # https://github.com/keyme/rack-timeout-puma/
  gem 'uglifier', '~> 4.2'  # https://github.com/lautis/uglifier/
  gem 'omniauth-rails_csrf_protection', '~> 1.0'  # https://github.com/cookpad/omniauth-rails_csrf_protection/
  gem 'skylight', '~> 5.1', '>= 5.1.1'  # https://github.com/skylightio/skylight-ruby/
  gem 'puma_worker_killer', '~> 0.3.1'  # https://github.com/schneems/puma_worker_killer/
  gem 'procore-sift', '~> 0.16.0'  # https://github.com/procore/sift/
  gem 'wisper', '~> 2.0', '>= 2.0.1'  # https://github.com/krisleech/wisper/  # https://karolgalanciak.com/blog/2019/11/30/from-activerecord-callbacks-to-publish-slash-subscribe-pattern-and-event-driven-design/
  gem 'devise-secure_password', '~> 2.0', '>= 2.0.1'  # https://github.com/valimail/devise-secure_password/
  gem 'haikunator', '~> 1.1', '>= 1.1.1'  # https://github.com/usmanbashir/haikunator/
  gem 'mime-types', '~> 3.3', '>= 3.3.1'  # https://github.com/mime-types/ruby-mime-types/
  gem 'http-2', '~> 0.11.0'  # https://github.com/igrigorik/http-2/
  gem 'attr_extras', '~> 6.2', '>= 6.2.4'  # https://github.com/barsoom/attr_extras/
  gem 'lru_redux', '~> 1.1'  # https://github.com/SamSaffron/lru_redux/
  gem 'devise_invitable', '~> 2.0', '>= 2.0.5'  # https://github.com/scambra/devise_invitable/
  gem 'lavatar', '~> 0.1.5'  # https://github.com/jkostolansky/lavatar/
  gem 'fast_blank', '~> 1.0'  # https://github.com/SamSaffron/fast_blank/
  gem 'httparty', '~> 0.18.1'  # https://github.com/jnunemaker/httparty/
  gem 'sanitize', '~> 6.0'  # https://github.com/rgrove/sanitize/
  gem 'paranoia', '~> 2.5'  # https://github.com/rubysherpas/paranoia
  gem 'rinku', '~> 2.0', '>= 2.0.6'  # https://github.com/vmg/rinku/
  gem 'diffy', '~> 3.4'  # https://github.com/samg/diffy/
  gem 'fastimage', '~> 2.2', '>= 2.2.4'  # https://github.com/sdsykes/fastimage/

  if rails_5?
    gsub_file "Gemfile", /gem 'sqlite3'/, "gem 'sqlite3', '~> 1.3.0'"
    gem 'webpacker', '~> 5.3'
  end
end

def set_application_name
  # Add Application Name to Config
  if rails_5?
    environment "config.application_name = Rails.application.class.parent_name"
  else
    environment "config.application_name = Rails.application.class.module_parent_name"
  end

  # Announce the user where they can change the application name in the future.
  puts "You can change application name inside: ./config/application.rb"
end

def add_simple_form
  generate "simple_form:install --bootstrap"
end

def add_users
  route "root to: 'home#index'"
  generate "devise:install"

  # Configure Devise to handle TURBO_STREAM requests like HTML requests
  inject_into_file "config/initializers/devise.rb", "  config.navigational_formats = ['/', :html, :turbo_stream]", after: "Devise.setup do |config|\n"

  inject_into_file 'config/initializers/devise.rb', after: "# frozen_string_literal: true\n" do <<~EOF
    class TurboFailureApp < Devise::FailureApp
      def respond
        if request_format == :turbo_stream
          redirect
        else
          super
        end
      end

      def skip_format?
        %w(html turbo_stream */*).include? request_format.to_s
      end
    end
  EOF
  end

  inject_into_file 'config/initializers/devise.rb', after: "# ==> Warden configuration\n" do <<-EOF
  config.warden do |manager|
    manager.failure_app = TurboFailureApp
  end
  EOF
  end

  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'
  generate :devise, "User", "first_name", "last_name", "announcements_last_read_at:datetime" # , "admin:boolean"

  # Set admin default to false
  # in_root do
  #   migration = Dir.glob("db/migrate/*").max_by{ |f| File.mtime(f) }
  #   gsub_file migration, /:admin/, ":admin, default: false"
  # end

  if Gem::Requirement.new("> 5.2").satisfied_by? rails_version
    gsub_file "config/initializers/devise.rb", /  # config.secret_key = .+/, "  config.secret_key = Rails.application.credentials.secret_key_base"
  end

  inject_into_file("app/models/user.rb", "omniauthable, :", after: "devise :")
end

def add_authorization
  generate 'pundit:install'
end

def add_webpack
  # Rails 6+ comes with webpacker by default, so we can skip this step
  return if rails_6?

  # Our application layout already includes the javascript_pack_tag,
  # so we don't need to inject it
  rails_command 'webpacker:install'
end

def add_javascript
  run "yarn add expose-loader local-time @rails/request.js" # @popperjs/core bootstrap

  if rails_5?
    run "yarn add @rails/actioncable@pre @rails/actiontext@pre @rails/activestorage@pre @rails/ujs@pre"
  end

  content = <<-JS
const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  Rails: '@rails/ujs'
}))
  JS

  insert_into_file 'config/webpack/environment.js', content + "\n", before: "module.exports = environment"
end

def add_hotwire
  rails_command "hotwire:install"
end

def copy_templates
  remove_file "app/assets/stylesheets/application.css"

  copy_file "Procfile"
  copy_file "Procfile.dev"
  copy_file ".foreman"

  directory "app", force: true
  directory "config", force: true
  # directory "lib", force: true

  route "get '/terms', to: 'home#terms'"
  route "get '/privacy', to: 'home#privacy'"
end

def add_sidekiq
  environment "config.active_job.queue_adapter = :sidekiq"

  insert_into_file "config/routes.rb",
    "require 'sidekiq/web'\n\n",
    before: "Rails.application.routes.draw do"

  # content = <<~RUBY
  #               authenticate :user, lambda { |u| u.admin? } do
  #                 mount Sidekiq::Web => '/sidekiq'

  #                 namespace :madmin do
  #                   resources :impersonates do
  #                     post :impersonate, on: :member
  #                     post :stop_impersonating, on: :collection
  #                   end
  #                 end
  #               end
  #           RUBY
  # insert_into_file "config/routes.rb", "#{content}\n", after: "Rails.application.routes.draw do\n"
end

def add_announcements
  generate "model Announcement published_at:datetime announcement_type name description:text"
  route "resources :announcements, only: [:index]"
end

def add_notifications
  generate "noticed:model"
  route "resources :notifications, only: [:index]"
end

def add_multiple_authentication
  insert_into_file "config/routes.rb", ', controllers: { omniauth_callbacks: "users/omniauth_callbacks" }', after: "  devise_for :users"

  generate "model Service user:references provider uid access_token access_token_secret refresh_token expires_at:datetime auth:text"

  template = """
  env_creds = Rails.application.credentials[Rails.env.to_sym] || {}
  %i{ facebook twitter github }.each do |provider|
    if options = env_creds[provider]
      config.omniauth provider, options[:app_id], options[:app_secret], options.fetch(:options, {})
    end
  end
  """.strip

  insert_into_file "config/initializers/devise.rb", "  " + template + "\n\n", before: "  # ==> Warden configuration"
end

def add_whenever
  run "wheneverize ."
end

def add_friendly_id
  generate "friendly_id"
  insert_into_file( Dir["db/migrate/**/*friendly_id_slugs.rb"].first, "[5.2]", after: "ActiveRecord::Migration")
end

def stop_spring
  run "spring stop"
end

def add_sitemap
  rails_command "sitemap:install"
end

# Main setup
add_template_repository_to_source_path

add_gems

after_bundle do
  set_application_name
  stop_spring
  add_simple_form
  add_users
  add_authorization
  add_webpack
  add_javascript
  add_announcements
  add_notifications
  add_multiple_authentication
  add_sidekiq
  add_friendly_id
  add_hotwire

  copy_templates
  add_whenever
  add_sitemap

  rails_command "active_storage:install"

  # Commit everything to git
  unless ENV["SKIP_GIT"]
    git :init
    git add: "."
    # git commit will fail if user.email is not configured
    begin
      git commit: %( -m 'Initial commit' )
    rescue StandardError => e
      puts e.message
    end
  end

  say
  say "Startup is done!", :blue
  say
  say "To get started with your new app:", :green
  say "  cd #{original_app_name}"
  say
  say "  # Update config/database.yml with your database credentials"
  say
  say "  rails db:create db:migrate"
  say "  gem install foreman"
  say "  foreman start # Run Rails, sidekiq, and webpack-dev-server"
end
