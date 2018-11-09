# README

- Rails version: 5.2.1
- Ruby version: 2.5.1

# General 

## [Devise](https://github.com/plataformatec/devise)

- Devise user setup is done (sign in, sign out, confirmation, reset password)
- Add Username and ability to login with e-mail or username
- Add Last Seen to user (5 minutes threshold for each `authenticate_user!` call)
- Lock account for 2 hours if 10 wrong login attempts are made and send e-mail to unlock it imidieatly
- Create user without confirmation method for terminal usage

## Development

### [Awesome Print](https://github.com/awesome-print/awesome_print)

Awesome Print is a Ruby library that pretty prints Ruby objects in full color exposing their internal structure with proper indentation. Rails ActiveRecord objects and usage within Rails templates are supported via included mixins.

To use it edit your irbrc file: `vi ~/.irbrc` and append following lines.

```
require "awesome_print"
IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:HISTORY_FILE] = '~/.irb-history'
AwesomePrint.irb!
```

### [Annotate](https://github.com/ctran/annotate_models)

Add a comment summarizing the current schema to the top or bottom of each of
your...

- ActiveRecord models
- Fixture files
- Tests and Specs
- Object Daddy exemplars
- Machinist blueprints
- Fabrication fabricators
- Thoughtbot's factory_bot factories, i.e. the (spec|test)/factories/<model>_factory.rb files
- routes.rb file (for Rails projects)

### [Letter Opener](https://github.com/fgrehm/letter_opener_web)

Preview email in the default browser instead of sending it. This means you do not need to set up email delivery in your development environment, and you no longer need to worry about accidentally sending a test email to someone else's address.

### [Overcommit](https://github.com/brigade/overcommit)

Overcommit is a tool to manage and configure. In addition to supporting a wide variety of hooks that can be used across multiple repositories, you can also define hooks specific to a repository which are stored in source control. You can also easily add your existing hook scripts without writing any Ruby code.

`overcommit --install`

OR

Install hooks with force: `overcommit --force`

Sign: `overcommit --sign`

#### Disabling Overcommit
If you have scripts that execute git commands where you don't want Overcommit hooks to run, you can disable Overcommit entirely by setting the `OVERCOMMIT_DISABLE` environment variable.

`OVERCOMMIT_DISABLE=1 ./my-custom-script`

### [Bullet](https://github.com/flyerhzm/bullet)

The Bullet gem is designed to help you increase your application's performance by reducing the number of queries it makes. It will watch your queries while you develop your application and notify you when you should add eager loading (N+1 queries), when you're using eager loading that isn't necessary and when you should use counter cache.


# TODO:
[] Overcommit test on other machine

[] Docker
[] Grape
[] Restful User Actions
[] Documentation
[] Fast JSON API

