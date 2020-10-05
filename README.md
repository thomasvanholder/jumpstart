
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
```
yarn add tailwindcss
yarn add @tailwindcss/ui
```


2. Create a Stylsheets folder in the Javascript folder
- 2a. Create an application.scss file and add
```scss
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
```
- 2b. Create a taildwind.config.js file and add [this content](https://github.com/thomasvanholder/jumpstart/blob/main/tailwind.config.js)


3. Replace postcss.config.js file with [this content](https://github.com/thomasvanholder/jumpstart/blob/main/postcss.config.js)


4. Import tailwind config file into application.js
```javascript
import "stylesheets/application";
```
