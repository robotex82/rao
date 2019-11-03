#!/bin/bash
GEM_NAME=${PWD##*/}
INSTALL_NAME=${GEM_NAME//rao-/rao\:}

# Delete old dummy app
rm -rf spec/dummy

# Generate new dummy app
DISABLE_MIGRATE=true bundle exec rake dummy:app
rm spec/dummy/.ruby-version

# Satisfy prerequisites
cd spec/dummy

# Use correct Gemfile
rm Gemfile
sed -i "s|../Gemfile|../../../Gemfile|g" config/boot.rb

# Add ActiveStorage
# rails active_storage:install

# I18n configuration
# touch config/initializers/i18n.rb
# echo "Rails.application.config.i18n.available_locales = [:en, :de]" >> config/initializers/i18n.rb
# echo "Rails.application.config.i18n.default_locale    = :de" >> config/initializers/i18n.rb

# I18n routing
# touch config/initializers/route_translator.rb
# echo "RouteTranslator.config do |config|" >> config/initializers/route_translator.rb
# echo "  config.force_locale = true" >> config/initializers/route_translator.rb
# echo "end" >> config/initializers/route_translator.rb

# Add turbolinks
# sed -i "15irequire 'turbolinks'" config/application.rb

# Install administrador
# rails generate administrador:install

# Install SimpleForm
# rails generate simple_form:install --bootstrap

# Install cmor_core_backend
# rails g cmor:core:backend:install

# Setup specs
rails g model post title body:text published_at:timestamp

# Install
rails generate $INSTALL_NAME:install
rails db:migrate db:test:prepare
