# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simplify/admin/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "simplify-admin-rails"
  spec.version       = Simplify::Admin::Rails::VERSION
  spec.authors       = ["Naive CAI"]
  spec.email         = ["835010809@qq.com"]

  spec.summary       = %q{ Quickly start admin page using SimplifyAdmin theme. }
  spec.description   = %q{ Quickly start admin page using SimplifyAdmin theme. }
  spec.homepage      = "https://github.com/NaiveCAI/simplify_admin_template"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
