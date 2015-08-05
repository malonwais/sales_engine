require_relative 'test_helper'
require_relative '../lib/customer.rb'

class CustomerTest < MiniTest::Test
  @@engine = SalesEngine.new
  @@engine.startup
  
  def engine
    @@engine
  end
  
  def test_invoices__it_returns_an_array_of_invoices
    customer = engine.customer_repository.find_by_id('21')
    
    assert_equal Array, customer.invoices.class
    assert customer.invoices.all?{|invoice| invoice.class == Invoice}
  end
  
  def test_invoices__it_returns_the_correct_invoices
    customer = engine.customer_repository.find_by_id('21')
    
    invoice_ids = customer.invoices.map {|invoice| invoice.id}
    merchant_ids = customer.invoices.map {|invoice| invoice.merchant_id}
    
    assert_equal [116, 115, 114, 113, 112, 111, 110, 109], invoice_ids
    assert_equal [80, 87, 44, 18, 71, 72, 45, 96], merchant_ids
  end
  
  def test_invoices__it_returns_an_empty_array_when_no_invoices_are_associated_with_the_customer
    
    input_data = ['9892873429834','Fake','name','0932','09342']
    
    customer = Customer.new(input_data, engine.customer_repository)
    
    assert_equal [], customer.invoices
  end
  def test_transactions__it_returns_an_empty_array_when_no_arrays_exist_for_that_customer
    skip
    input_data = ['999999999','Fake','name','0932','09342']
    
    customer = Customer.new(input_data, engine.customer_repository)
    
    assert_equal [], customer.transactions
  end
  
  
  
end
