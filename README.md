
## Create a new repo

2 templates availabel, with or without devise.
Run one of the command below and change _PROJECT-NAME_ to the name of your new project.


### Rails 6 | Tailwind 2.0 🏳️‍🌈 | Devise 🔐
- navbar
- styled devise/views from [thomasvanholder/devise](https://github.com/thomasvanholder/devise)
- first and last name added to user model
- icons

__To Do__
- [ ] application controller, sanitize extra paramaters

```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/template.rb \
  PROJECT-NAME
```

### Rails 6 | Tailwind 2.0 🏳️‍🌈
```bash
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/basic.rb \
  PROJECT-NAME
```

###Tailwind 2.0
- javascript/components from [thomasvanholder/tailwind-components](https://github.com/thomasvanholder/tailwind-components)

###Assets
- javascript/components from [thomasvanholder/assets](https://github.com/thomasvanholder/assets)
