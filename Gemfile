source 'https://rubygems.org'

gem 'rails', '~> 5.0.0'
gem 'pg', '~> 0.18'
gem 'rgeo'
gem 'activerecord-postgis-adapter'

gem 'puma', '~> 3.0'
gem 'bootstrap-sass'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

# Redis
gem 'redis', '~> 3.0'
gem 'redis-rails'
gem 'redis-namespace'

# Sidekiq
gem 'sidekiq'

# ElasticSearch
gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# Static Resource
gem 'mini_magick'
gem 'qiniu-rs'
gem 'carrierwave'
gem 'carrierwave-qiniu', git: 'https://github.com/huobazi/carrierwave-qiniu'

# Devise
gem 'devise'

# Json Serializer
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'awesome_print'
  gem 'better_errors'
  gem 'pry'
end

group :development do
  # N + 1 problems
  gem 'bullet'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
