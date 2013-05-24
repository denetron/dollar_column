$:.unshift "lib"
require 'active_record/dollar_column'

ActiveRecord::Base.class_eval do
  include ActiveRecord::DollarColumn
end