
## Create a new repo

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
