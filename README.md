# Rails Boilerplate

- Rails version: 5.2.1
- Ruby version: 2.5.3

# General 

## [Devise](https://github.com/plataformatec/devise)

- Devise user setup is done (sign in, sign out, confirmation, reset password)
- Add 'username' and ability to login with e-mail or username
- Add Last Seen to the user (5 minutes threshold for each `authenticate_user!` call)
- Lock account for 2 hours if 10 wrong login attempts are made and send an e-mail to unlock it immediately
- Create a user without confirmation method for terminal usage

## [Grape](https://github.com/ruby-grape/grape)

Grape is a REST-like API framework for Ruby. It's designed to run on Rack or complement existing web application frameworks such as Rails and Sinatra by providing a simple DSL to easily develop RESTful APIs. It has built-in support for common conventions, including multiple formats, subdomain/prefix restriction, content negotiation, versioning and much more.

You can check the [API folder](/app/controllers/api) to see Grape files and `http://#{RAILS_HOST_WITH_PORT}/documentation` to use automatically generated Swagger documentation page via [grape-swagger](https://github.com/ruby-grape/grape-swagger) gem.

### [API Pagination](https://github.com/davidcelis/api-pagination)

Paginate in your headers, not in your response body.
This follows the proposed [RFC-8288](https://tools.ietf.org/html/rfc8288) standard for Web linking.

You can check [example file](/app/controllers/api/v1/users.rb) to see how to use it.

[Pagy](https://github.com/ddnexus/pagy) is the installed and configured to use in api pagination. You can change the default values in [configuration file](/config/initializers/api_pagination.rb).


## Development

### [Awesome Print](https://github.com/awesome-print/awesome_print)

Awesome Print is a Ruby library that pretty prints Ruby objects in full color exposing their internal structure with proper indentation. Rails ActiveRecord objects and usage within Rails templates are supported via included mixins.

To use it edit your pryrc file: `vi ~/.pryrc` and append following lines.

```
require "awesome_print"
AwesomePrint.pry!
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

Preview the e-mail in your browser instead of really sending it. This means you do not need to set up any e-mail delivery method in your development environment, and you no longer need to worry about accidentally sending a test email to users.

To access your inbox visit: `http://#{RAILS_HOST_WITH_PORT}/letter_opener`

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

### [Pry-Rails](https://github.com/rweng/pry-rails)

Avoid repeating yourself, use pry-rails instead of copying the initializer to every rails project.
This is a small gem which causes `rails console` to open [pry](http://pry.github.com/). It therefore depends on *pry*.

## Docker

This project aims to build a lean Docker image for use in production. Therefore it's based on the official Alpine Ruby image, uses multi-stage building and some [optimizations that I've learned ledermann's blog](https://www.georg-ledermann.de/blog/2018/04/19/dockerize-rails-the-lean-way/). This results in an image size of ~120MB.

### Multi container architecture

There is a separate **docker-compose.yml** for every environment: [development](docker-compose.yml), [test](docker-compose.test.yml) and [production](docker-compose.production.yml). The whole stack is divided into multiple different containers:

- **app:** Main part. It contains the Rails code to handle web requests (by using the [Puma](https://github.com/puma/puma) gem). See the [Dockerfile](/Dockerfile) for details. The image is based on the Alpine variant of the official [Ruby image](https://hub.docker.com/_/ruby/) and uses multi-stage building.
- **worker:** Background processing. It contains the same Rails code, but only runs Sidekiq
- **db:** PostgreSQL database
- **elasticsearch:** Full text search engine
- **memcached:** Memory caching system (used from within the app via the [Dalli](https://github.com/petergoldstein/dalli) gem)
- **redis:** In-memory key/value store (used by Sidekiq and ActionCable)
- **backup:** Regularly backups the database as a dump via CRON to an Amazon S3 bucket

For running tests using RSpec, there is an additional container:

- **selenium:** Standalone Chrome for executing system tests containing JavaScript

### Check it out!

To start up the application in your local Docker environment:

```bash
docker-compose build
docker-compose run app yarn install
docker-compose up
```

You can access the rails server with: `localhost:3000`

Note: You may need `sudo sysctl -w vm.max_map_count=262144` if you're going to run elasticsearch container too.

### CI

The repo contains [.travis.yml](/.travis.yml) and [.gitlab-ci.yml](/.gitlab-ci.yml) that run tests and push new image if there is no error.

### Production deployment

The Docker image build for production is different from development or test. It includes precompiled assets only (no node_modules and no sources). The [test folder](/test) is removed and the Alpine packages for Node and Yarn are not installed.

The stack is ready to host with [nginx proxy](https://github.com/jwilder/nginx-proxy) and [letsencrypt-nginx-proxy-companion](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion). See [docker-compose.production.yml](/docker-compose.production.yml) for example setup.
