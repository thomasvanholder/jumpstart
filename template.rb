run "if uname | grep -q 'Darwin'; then pgrep spring | xargs kill -9; fi"

# GEMFILE

inject_into_file 'Gemfile', before: 'group :development, :test do' do
  <<~RUBY
    gem 'devise'
    gem 'autoprefixer-rails'
    gem 'font-awesome-sass'
  RUBY
end

inject_into_file 'Gemfile', after: 'group :development, :test do' do
  <<-RUBY
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  RUBY
end

gsub_file('Gemfile', /# gem 'redis'/, "gem 'redis'")

def add_tailwind
  run "yarn remove @rails/webpacker"
  run "yarn add rails/webpacker"

  gsub_file('Gemfile', /gem 'webpacker'/, "gem 'webpacker', github: 'rails/webpacker'")

  run "yarn add tailwindcss@latest postcss@latest autoprefixer@latest"
  run 'yarn add @tailwindcss/forms @tailwindcss/typography @tailwindcss/aspect-ratio'

  run "mkdir -p app/javascript/stylesheets"
  run "touch app/javascript/stylesheets/application.scss"

  inject_into_file "app/javascript/stylesheets/application.scss" do <<~EOF
      @import 'tailwindcss/base';
      @import 'tailwindcss/components';
      @import 'tailwindcss/utilities';
      EOF
    end

  run "npx tailwindcss init --full"
  gsub_file "tailwind.config.js", /plugins:\s\[],/, "plugins: [require('@tailwindcss/ui'),require('@tailwindcss/typography'),
    require('@tailwindcss/aspect-ratio')],"
  run "mv tailwind.config.js app/javascript/stylesheets/tailwind.config.js"

  append_to_file("app/javascript/packs/application.js", 'import "stylesheets/application"')
  inject_into_file("./postcss.config.js",
  "let tailwindcss = require('tailwindcss');\n",  before: "module.exports")
  inject_into_file("./postcss.config.js", "\n    tailwindcss('./app/javascript/stylesheets/tailwind.config.js'),", after: "plugins: [")

  run "mkdir -p app/javascript/stylesheets/components"
end

def add_assets
  # run 'rm -rf app/assets'
  run 'rm -rf vendor'

  # run 'curl -L https://github.com/thomasvanholder/assets/archive/master.zip > assets.zip'
  # run 'unzip assets.zip -d app && rm assets.zip && mv app/assets-master app/assets'

  gsub_file('config/environments/development.rb', /config\.assets\.debug.*/, 'config.assets.debug = false')
end

add_assets

# Layout
########################################
if Rails.version < "6"
  scripts = <<~HTML
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>
    <%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
  HTML
  gsub_file('app/views/layouts/application.html.erb', "<%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>", scripts)
end
gsub_file('app/views/layouts/application.html.erb', "<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload' %>", "<%= javascript_pack_tag 'application', 'data-turbolinks-track': 'reload', defer: true %>")
style = <<~HTML
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
      <%= stylesheet_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
HTML
gsub_file('app/views/layouts/application.html.erb', "<%= stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>", style)


def add_flashes
  file 'app/views/shared/_flashes.html.erb', <<~HTML
  <% if notice %>

    <div class="fixed inset-x-0 top-0 flex items-end justify-right px-4 py-6 sm:p-6 justify-end z-50 ">
      <div data-controller="alert" class="max-w-sm w-full shadow-lg rounded px-4 py-3 rounded relative bg-green-100 border-l-4 border-green-500 text-green-700">
        <div class="p-2">
          <div class="flex items-start">
            <div class="ml-3 w-0 flex-1 pt-0.5">
              <p class="text-sm leading-5 font-medium">
              <%= notice[:title] %>
              </p>
              <% if notice[:content] %>
                <p class="text-xs font-light">
                <%= notice[:content] %>
                </p>
              <% end %>
            </div>
            <div class="ml-4 flex-shrink-0 flex">
              <button data-action="alert#close" class="inline-flex text-green-700 focus:outline-none focus:text-gray-300 transition ease-in-out duration-150">
                <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"/>
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

  <% end %>
  HTML
end

def add_navbar
  run 'curl -L https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/templates/_navbar.html.erb > app/views/shared/_navbar.html.erb'
end

inject_into_file 'app/views/layouts/application.html.erb', after: '<body>' do
  <<-HTML
    <%= render 'shared/navbar' %>
    <%= render 'shared/flashes' %>
  HTML
end

# README
########################################
markdown_file_content = <<-MARKDOWN
Rails app generated by [thomasvanholder/jumpstart](https://github.com/thomasvanholder/jumpstart), inspired by the [Le Wagon](https://www.lewagon.com).
MARKDOWN
file 'README.md', markdown_file_content, force: true

# Generators
########################################
generators = <<~RUBY
  config.generators do |generate|
    generate.assets false
    generate.helper false
    generate.test_framework :test_unit, fixture: false
  end
RUBY

def set_routes
  route "root to: 'pages#home'"
end

def add_devise
  generate('devise:install')
  generate('devise', 'User')

  run 'rm app/controllers/application_controller.rb'
  file 'app/controllers/application_controller.rb', <<~RUBY
    class ApplicationController < ActionController::Base
    #{  "protect_from_forgery with: :exception\n" if Rails.version < "5.2"}  before_action :authenticate_user!
    end
  RUBY

  rails_command 'db:migrate'
  generate('devise:views')

  run 'rm app/controllers/pages_controller.rb'
  file 'app/controllers/pages_controller.rb', <<~RUBY
    class PagesController < ApplicationController
      skip_before_action :authenticate_user!, only: [ :home ]

      def home
      end
    end
  RUBY
end

def add_git_ignore
  append_file '.gitignore', <<~TXT
    # Ignore .env file containing credentials.
    .env*
    # Ignore Mac and Linux file system files
    *.swp
    .DS_Store
  TXT
end

environment generators

########################################
# AFTER BUNDLE
########################################
after_bundle do
  # Generators: db + pages controller
  ########################################
  rails_command 'db:drop db:create db:migrate'
  generate(:controller, 'pages', 'home', '--skip-routes', '--no-test-framework')

  set_routes
  add_devise
  add_git_ignore

  # Environments
  ########################################
  environment 'config.action_mailer.default_url_options = { host: "http://localhost:3000" }', env: 'development'
  environment 'config.action_mailer.default_url_options = { host: "http://TODO_PUT_YOUR_DOMAIN_HERE" }', env: 'production'

  # Webpacker / Yarn
  ########################################
  append_file 'app/javascript/packs/application.js', <<~JS


    // ----------------------------------------------------
    // ABOVE IS RAILS DEFAULT CONFIGURATION
    // WRITE YOUR OWN JS STARTING FROM HERE 👇
    // ----------------------------------------------------

    // External imports
    import "../stylesheets/application.scss";


    // Internal imports, e.g:
    // import { initSelect2 } from '../components/init_select2';

    document.addEventListener('turbolinks:load', () => {
      // Call your functions here, e.g:
      // initSelect2();
    });
  JS

  inject_into_file 'config/webpack/environment.js', before: 'module.exports' do
    <<~JS
      const webpack = require('webpack');
      // Preventing Babel from transpiling NodeModules packages
      environment.loaders.delete('nodeModules');

      environment.plugins.prepend('Provide',
        new webpack.ProvidePlugin({
        })
      );
    JS
  end

  # Dotenv
  ########################################
  run 'touch .env'

  # Rubocop
  ########################################
  run 'curl -L https://raw.githubusercontent.com/lewagon/rails-templates/master/.rubocop.yml > .rubocop.yml'

  # Git
  ########################################
  git add: '.'
  git commit: "-m 'Initial commit with template from https://github.com/thomasvanholder/jumpstart'"

  # Fix puma config
  gsub_file('config/puma.rb', 'pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }', '# pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }')


  add_tailwind
  add_flashes
  add_navbar


  say
  say "Kickoff app successfully created! 👍", :blue
  say
  say "Switch to your app by running:", :green
  say "  cd #{app_name}"
  say

end
