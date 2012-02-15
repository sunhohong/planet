source 'http://rubygems.org'

gem 'rails', '3.1.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'rspec-rails', :group => [:test, :development]
group :test do
  # Pretty printed test output
  gem 'turn', '0.8.2', :require => false
  gem 'spork', '~> 0.9.0.rc', :require => false
  gem 'spork-testunit'
  # gem 'rspec'
  gem 'factory_girl_rails'  # for fixture
  gem 'capybara'            # for simulating user
  gem 'guard-rspec'         # for automately running tests (rspec, test-unit, etc.)
  gem 'guard-spork'         # to intergrate guard with spork
  # gem 'database_cleaner'
end

# for this project
gem 'sunspot_rails', :git => 'https://github.com/sunspot/sunspot.git'       # for solr interface
gem 'sunspot_solr', '1.3.0'              # for solr server
gem 'simple_form', '~> 2.0.0rc', :git => 'git://github.com/plataformatec/simple_form.git'       # for bootstrap simple form
gem 'show_for'          # for bootstrap 
gem 'kaminari'          # for pagination
gem 'sunspot_with_kaminari', '~> 0.1'     # for sunspot & kaminari intergration
gem 'paperclip', '~> 2.4'         # for image upload
gem 'awesome_nested_set', '~> 2.1.2'          # for nested category building
gem 'jquery-ui-themes', '~> 0.0.4' # for jquery-ui css     TODO - remove after Ohgyun has worked.
#gem 'less-rails-bootstrap'          # for using less
gem 'httpclient'      # for interact with other web sites

gem 'therubyracer'      # for javascript engine on linux

gem 'unicorn'           # unicorn server
gem 'rack', '1.3.5'     # for unicorn
