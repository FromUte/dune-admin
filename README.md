# Neighborly::Admin

[![Build Status](https://travis-ci.org/neighborly/neighborly-admin.png?branch=master)](https://travis-ci.org/neighborly/neighborly-admin) [![Code Climate](https://codeclimate.com/github/neighborly/neighborly-admin.png)](https://codeclimate.com/github/neighborly/neighborly-admin)

## What

This is the admin of [Neighborly](https://github.com/luminopolis/neighborly), a Civic Crowdfunding platform.

## How

Include this gem as dependency of your project, adding the following line in your `Gemfile`.

```ruby
# Gemfile
gem 'neighborly-admin'
```

And install the migrations:

```
$ bundle exec rake railties:install:migrations db:migrate
```

Neighborly::Admin is a Rails Engine, integrating with your (Neighborly) Rails application with very little of effort. To turn the engine on, mount it in an appropriate route:

```ruby
# config/routes.rb
mount Neighborly::Admin::Engine => '/admin/', as: :neighborly_admin
```
And load our JavaScript:

```
//= require neighborly-admin
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Running specs

We prize for our test suite and coverage, so it would be great if you could run the specs to ensure that your patch is not breaking the existing codebase.

When running specs for the first time, you'll need to download Neighborly's source code to be tested against your version of the gem. The following command will install the dummy app in `spec/dummy`.

```
$ git submodule init
$ git submodule update
```

And before you go, you need to initialize a database for this "dummy" app.

```
$ cd spec/dummy
$ cp config/database.sample.yml config/database.yml
$ bundle install
$ RAILS_ENV=test rake db:create db:migrate
$ cd ../../
```

To run the specs just run:

```
$ bundle exec rake spec
```

## License

Licensed under the [MIT license](LICENSE.txt).
