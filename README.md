# Simplify::Admin::Rails
- Remove js part of simplify\_admin

## Installation
- bootstrap-sass, font-awesome-rails, jQuery-rails are necessary. And require them above the simplify\_admin css

Add this line to your application's Gemfile:

```ruby
gem 'simplify-admin-rails'
gem 'jquery-rails'
gem 'font-awesome-rails'
```

And then execute:
    $ bundle

Or install it yourself as:
    $ gem install simplify-admin-rails

## Usage
```ruby
# Add it in admin.scss and admin.js
@import bootstrap
@import font-awesome
@import simplify_admin

//= require simplify_admin
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

