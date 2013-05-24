Gem::Specification.new do |s|
  s.name        = "dollar_column"
  s.version     = "1.0.2"
  s.date        = "2013-05-24"
  s.summary     = "Helper for dealing with money amounts."
  s.description = "Provides helper methods so you can store dollar amounts in cents as integers (or floats if you need to store fractional pennies) but still do your operations in dollars"
  s.authors     = "Daniel Ballenger"
  s.email       = "dballenger@denetron.com"
  s.files       = ["lib/dollar_column.rb", "lib/active_record/dollar_column.rb"]
  s.homepage    = "https://github.com/denetron/dollar_column"
  s.add_runtime_dependency "activerecord", ">= 3.0.0"
  s.required_ruby_version = ">= 1.9"
end