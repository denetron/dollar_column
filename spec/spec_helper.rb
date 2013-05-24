begin; require 'turn/autorun'; rescue LoadError; end
require 'minitest/autorun'

# Shim so the include of the init file works
module ActiveRecord
  class Base
  end
end

require File.expand_path(File.dirname(__FILE__) + "/../lib/dollar_column")

def fixture_path(name)
  File.expand_path(File.join(File.dirname(__FILE__), "fixtures", name))
end

# Test class
class DollarColumnTestCase
  include ActiveRecord::DollarColumn
  
  def write_attribute(attribute, value)
    send("#{attribute}=", value)
  end
end

