# Simplify::Admin::Rails
- Js part of simplify\_admin has been removed.

## Installation
- __*bootstrap-sass, font-awesome-rails, jQuery-rails*__ are necessary. And require them above the simplify\_admin css

- Add this line to your application's Gemfile:
```ruby
gem 'simplify-admin-rails'
gem 'jquery-rails'
gem 'font-awesome-rails'
```
- Then run: `bundle install`
- Or install it yourself as: `gem install simplify-admin-rails`
- Simplify admin use ionicons fonts, put them under `/assets/fonts` directory.

## Usage
```javascript
// Add it in admin.scss and admin.js
@import bootstrap
@import font-awesome
@import simplify_admin

//= require simplify_admin
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
