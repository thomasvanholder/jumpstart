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

1. Add [Tailwind CSS](https://tailwindcss.com/) and [Tailwind UI (components)](https://tailwindui.com/components) with Yarn
<br>`yarn add tailwindcss`
<br>`yarn add @tailwindcss/ui`





2. Import tailwind into application.scss file
```scss
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
```

3. add tailwind config file to javascript/css folder
[I'm an inline-style link with title](https://www.google.com "Tailwind config")

4. Import tailwind config file into application.js
```javascript
import "stylesheets/application";
```
