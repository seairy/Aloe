if RUBY_VERSION =~ /1.9/ # assuming you're running Ruby ~1.9
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'rails', '3.2.14'
gem 'mysql'
gem 'mysql2'
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'rmagick'
gem 'will_paginate'
gem 'RedCloth'
gem 'ekuseru'
gem 'bcrypt-ruby', '~> 3.0.0'
gem 'paperclip'
gem 'carrierwave'
gem 'capistrano', '2.15.5'
gem 'sunspot_rails'
gem 'sunspot_solr'
gem 'rails_kindeditor', '~> 0.4.0'
gem 'validates_email_format_of', :git => 'git://github.com/alexdunae/validates_email_format_of.git'
gem 'ruby-pinyin', :git => 'git://github.com/janx/ruby-pinyin.git'
gem 'awesome_nested_set'
gem 'thin'

group :production do
  gem 'execjs'
  gem 'therubyracer'
end
