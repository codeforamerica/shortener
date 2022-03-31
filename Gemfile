source 'https://rubygems.org'
ruby_version = File.read(File.join(File.dirname(__FILE__), '.ruby-version')).strip
ruby ruby_version

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'language_filter'
gem 'pg'
gem 'pry-rails'
gem 'puma', '~> 4.3'
gem 'puma_worker_killer'
gem 'rails', '~> 6.0.2'
gem 'sass-rails', '>= 6'
gem 'sentry-raven'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'eefgilm'
  gem 'lintstyle', github: 'bensheldon/lintstyle'
  gem 'listen'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-email'
  gem 'climate_control'
  gem 'launchy', require: false
  gem 'selenium-webdriver'
  gem 'webmock'
end
