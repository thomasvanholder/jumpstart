
## Create a new repo

Tailwindcss 🏳️‍🌈 + Devise 🔐
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
- [] add tailwind components
- [] add first_name, last_name to user model (devise)
- [] add icons folder into stylesheets
- [] add module inline svg render?
- [] change name search to website
- [] swap devise folder
  - without username
  - run migration to add first and last name to users table
  - application controller, sanitize extra paramaters
