# Simplify::Admin::Rails
- Remove some charts plugins in simplify\_admin

## Installation
- Boostrap, font-awesome, jQuery-rails are necessary. And require them above the simplify\_admin
- jQuery <= 2.0 is needed as well. If the version bigger then 2, simplify js will get errors.

Add this line to your application's Gemfile:

```ruby
gem 'simplify-admin-rails'
gem 'jquery-rails'
gem 'font-awesome'
```

And then execute:
    $ bundle

Or install it yourself as:
    $ gem install simplify-admin-rails

## Usage
```ruby
# Add it in admin.js
//= require jquery2
//= require jquery_ujs
//= require bootstrap
//= require simplify_admin/simplify_admin

# Add it in admin.css
/*
 *=require bootstrap
 *=require font-awesome
 *=require simplify_admin/simplify_admin
*/
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

