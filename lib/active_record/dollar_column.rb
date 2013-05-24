require 'bigdecimal'

module ActiveRecord # :nodoc:
  module DollarColumn
    def self.included(base) # :nodoc:
      base.extend ClassMethods
    end
    
    module ClassMethods
      def dollar_column(*attr_names)
        if attr_names.size == 1 && attr_names[0].is_a?(Symbol)
          generate_dollar_methods(attr_names[0])
        elsif attr_names.flatten != attr_names
          dollar_column(*attr_names.flatten)
        else
          attr_names.each do |attr_each|
            generate_dollar_methods(attr_each.to_s)
          end
        end
      end
      
      def generate_dollar_methods(attr_name)
        define_method(attr_name) do
          (BigDecimal.new(send("#{attr_name}_in_cents").to_s) / 100).to_f
        end
        
        define_method("decimal_#{attr_name}") do
          BigDecimal.new(send("#{attr_name}_in_cents").to_s) / 100
        end
        
        define_method("formatted_#{attr_name}") do
          sprintf "$%.2f", send(attr_name)
        end
        
        define_method("#{attr_name}=") do |value|
          write_attribute("#{attr_name}_in_cents", (BigDecimal.new(value) * 100).to_f)
        end
      end
    end
  end
end
