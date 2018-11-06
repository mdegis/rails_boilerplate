# README

- Rails version: 5.2.1
- Ruby version: 2.5.1

# Gems

## User:

- Devise setup is done (confirmation, reset password)
- Add Username
- Add Last Seen to user
- Lock if too mant wrong login requests for 2 hours and send e-mail to unlock imidieatly
- Create user without confirmation

## Development

- Awesome Print: `vi ~/.irbrc`

```
require "awesome_print"
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = '~/.irb-history'
AwesomePrint.irb!
```

- Annotate: see more in your model file

- Letter Opener: Local email send env

# TODO:

[] Docker
[] Grape
[] Restful User Actions
[] Documentation
[] Fast JSON API
