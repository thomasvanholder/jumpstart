Inspired by the [Le Wagon Rails templates](https://github.com/lewagon/rails-templates)

## Create a new repo

2 templates available, with or without devise.<br>
Run one of the commands below and change _PROJECT-NAME_ to the name of your new project.


### Rails 6 | Tailwind 2.0 🏳️‍🌈 | Devise 🔐
- styled navbar
- styled devise/views from [thomasvanholder/devise](https://github.com/thomasvanholder/devise)
- javascript/components from [thomasvanholder/tailwind-components](https://github.com/thomasvanholder/tailwind-components)
- assets and icons from [thomasvanholder/assets](https://github.com/thomasvanholder/assets)
- first and last name added to user model

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/template.rb \
  PROJECT-NAME
```

### Rails 6 | Tailwind 2.0 🏳️‍🌈
- styled navbar
- javascript/components from [thomasvanholder/tailwind-components](https://github.com/thomasvanholder/tailwind-components)
- assets and icons from [thomasvanholder/assets](https://github.com/thomasvanholder/assets)

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/basic.rb \
  PROJECT-NAME
```

__To Do__
- [ ] application controller, sanitize extra paramaters
- [ ] add more button colors as tailwind components
- [ ] remove login / signup button from navbar when no devise
