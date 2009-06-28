begin
  require 'active_record/dollars_and_cents'
  ActiveRecord::Base.class_eval do
    include ActiveRecord::DollarsAndCents
  end
rescue NameError
  nil
end