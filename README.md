
## Create a new repo

### with devise and tailwindcss
```
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/master.rb \
  PROJECT-NAME
```

#### without devise
```
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/minimal.rb \
  PROJECT-NAME
```

#### with devise
```
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/devise.rb \
  PROJECT-NAME
 ```


## Tailwind CSS
more info: https://web-crunch.com/posts/how-to-install-tailwind-css-using-ruby-on-rails

1. Install [Tailwind CSS](https://tailwindcss.com/) and [Tailwind UI (components)](https://tailwindui.com/components) with Yarn
```bash
yarn add tailwindcss
yarn add @tailwindcss/ui
```

2. Create a **stylsheets** folder in the Javascript folder
- 2a. In **stylsheets** create an application.scss file and add
```scss
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
```
- 2b. Create a taildwind.config.js file and add [this content](https://github.com/thomasvanholder/jumpstart/blob/main/tailwind.config.js)


3. Replace postcss.config.js file with [this content](https://github.com/thomasvanholder/jumpstart/blob/main/postcss.config.js)


4. Import tailwind config file into application.js
```javascript
import "../stylesheets/applications.scss";
```

5. Remove bootstrap from 
- application.js
```
import "bootstrap";
```
- Remove jquery, popper.js from webpacker environment.js
```
 $: 'jquery',
 jQuery: 'jquery',
 Popper: ['popper.js', 'default'] 
```
- 

6. Add stylesheet pack tag to application.html
```batch
<%= stylesheet_pack_tag 'application', 'data-turbolinks-track': 'reload' %>
```




## Tailwind CSS - script
```batch
run "yarn add tailwindcss"
run "yarn add tailwindcss @tailwindcss/ui"
run "yarn tailwind init"

run "mkdir app/javascript/stylesheets"
run "touch app/javascript/stylesheets/application.scss"

inject_into_file "app/javascript/stylesheets/application.scss" do <<~EOF
  @import 'tailwindcss/base';
  @import 'tailwindcss/components';
  @import 'tailwindcss/utilities';
  EOF
end

run "npx tailwindcss init --full"
run "mv tailwind.config.js app app/javascript/stylesheets"

inject_into_file "app/javascript/packs/application.js" do <<~EOF
  import "../stylesheets/applications.scss";
  EOF
end

inject_into_file "postcss.config.js", before: "require('postcss-import')" do <<~EOF
  require("tailwindcss")("./app/javascript/stylesheets/tailwind.config.js")
  EOF
end

inject_into_file "app/views/layouts/application.html.erb", before: "</head>" do <<~EOF
  <%= stylesheet_pack_tag 'application', media: 'all', 'data-turbolinks-track': 'reload' %>
  EOF
end

gsub_file "tailwind.config.js", /plugins:\s\[],/, "plugins: [require('@tailwindcss/ui')],"

gsub_file "tailwind.config.js", /purge:\s\[],/, <<-PURGE
  purge: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './src/**/*.html',
    './src/**/*.vue',
    './src/**/*.jsx',
  ],
PURGE
```
