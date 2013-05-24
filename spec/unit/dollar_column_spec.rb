require 'spec_helper'

describe ActiveRecord::DollarColumn do
  it "should generate methods for a single symbol given" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
    end
    
    test_object = DollarColumnTestCase.new
    
    test_object.respond_to?(:amount).must_equal true
    test_object.respond_to?(:amount=).must_equal true
  end
  
  it "should accept an array of attributes" do
    DollarColumnTestCase.instance_eval do
      dollar_column [:amount, :tax]
    end
    
    test_object = DollarColumnTestCase.new
    
    test_object.respond_to?(:amount).must_equal true
    test_object.respond_to?(:amount=).must_equal true
    
    test_object.respond_to?(:tax).must_equal true
    test_object.respond_to?(:tax=).must_equal true
  end
  
  it "should accept a non-array list of attributes" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount, :tax
    end
    
    test_object = DollarColumnTestCase.new
    
    test_object.respond_to?(:amount).must_equal true
    test_object.respond_to?(:amount=).must_equal true
    
    test_object.respond_to?(:tax).must_equal true
    test_object.respond_to?(:tax=).must_equal true
  end
  
  it "properly handles floats that would result in a rounding error when multiplied by 100" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
      
      attr_accessor :amount_in_cents
    end
    
    test_object = DollarColumnTestCase.new
    test_object.amount = "4.52"
    
    test_object.amount_in_cents.must_equal 452
  end
  
  it "accepts a float for input" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
      
      attr_accessor :amount_in_cents
    end
    
    test_object = DollarColumnTestCase.new
    test_object.amount = 4.52
    
    test_object.amount_in_cents.must_equal 452
  end
  
  it "accepts fractional pennies too" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
      
      attr_accessor :amount_in_cents
    end
    
    test_object = DollarColumnTestCase.new
    test_object.amount = "4.524"
    
    test_object.amount_in_cents.must_equal 452.4
  end
  
  it "properly returns a float in dollars" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
      
      attr_accessor :amount_in_cents
    end
    
    test_object = DollarColumnTestCase.new
    test_object.amount_in_cents = 452
    
    test_object.amount.must_equal 4.52
  end
  
  it "provides a formatted amount string" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
      
      attr_accessor :amount_in_cents
    end
    
    test_object = DollarColumnTestCase.new
    test_object.amount_in_cents = 452
    
    test_object.formatted_amount.must_equal "$4.52"
  end
  
  it "returns a decimal - vs float - notation" do
    DollarColumnTestCase.instance_eval do
      dollar_column :amount
      
      attr_accessor :amount_in_cents
    end
    
    test_object = DollarColumnTestCase.new
    test_object.amount_in_cents = 452.343
    
    test_object.decimal_amount.must_equal BigDecimal.new("4.52343")
  end
end