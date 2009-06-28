module ActiveRecord # :nodoc:
  module DollarsAndCents
    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end
  
    module ClassMethods
      def dollar_column(attr_name, options = {})
        if attr_name.is_a?(Symbol)
          generate_dollar_methods(attr_name)
        else
          attr_name.each do |attr_each|
            generate_dollar_methods(attr_each.to_s)
          end
        end
      end
      
      def generate_dollar_methods(attr_name)
        define_method(attr_name) do |*optional|
          send("#{attr_name}!", *optional) rescue nil
        end
        
        define_method("#{attr_name}!") do |*optional|
          return sprintf("%.02f", (send("#{attr_name}_in_cents").to_f / 100)).to_f
        end
        
        define_method("#{attr_name}=") do |value|
          write_attribute("#{attr_name}_in_cents", value.to_f * 100)
        end
      end
    end
  end
end
