### minimal
`
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/minimal.rb \
  PROJECT-NAME
 `
  
### devise
`
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/devise.rb \
  PROJECT-NAME
`

### Add Tailwind CSS

1. Install [Tailwind CSS](https://tailwindcss.com/) and [Tailwind UI (components)](https://tailwindui.com/components) with Yarn
<br>`yarn add tailwindcss`
<br>`yarn add @tailwindcss/ui`

2. Create a Stylsheets folder in the Javascript folder
- 2a. Create an application.scss file and add
```scss
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
```
- 2b. Create a taildwind.config.js file and add [this content]()

3. Replace postcss.config.js file with [this content](https://github.com/thomasvanholder/jumpstart/blob/main/postcss.config.js)

4. add tailwind config file to javascript/css folder
[I'm an inline-style link with title](https://www.google.com "Tailwind config")


5. Import tailwind config file into application.js
```javascript
import "stylesheets/application";
```
