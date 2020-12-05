
## Create a new repo

Rails 6 >> Tailwind 2.0 🏳️‍🌈 >> Devise 🔐

```
rails new \
  --database postgresql \
  --webpack \
  -m https://raw.githubusercontent.com/thomasvanholder/jumpstart/main/template.rb \
  PROJECT-NAME
```


TODO:
**navbar component**
- [x] add navbar into templates folder
- [x] add icons folder into project
- [x] add tailwind components
- [x] add first_name, last_name to user model (devise)
- [x] add icons folder into stylesheets
- [x] add helper inline svg render
- [x] swap devise folder
  - [x] without username, run migration to add first and last name to users table
  - application controller, sanitize extra paramaters


**Devise
- user table inclusive of first and last name
