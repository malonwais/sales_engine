require_relative 'test_helper'
require_relative '../lib/customer.rb'

class CustomerTest < MiniTest::Test

  # def test_can_find_invoices
  #   engine = SalesEngine.new
  #   engine.startup
  #   # engine.customer_repository.map_data(Customer,'test/fixtures/customers.csv')
  #   # engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')
  #
  #   assert_equal 8, engine.customer_repository.invoices('1').size
  # end


  @@engine = SalesEngine.new
  @@engine.startup

def engine
  @@engine
end

def test_invoices__it_returns_an_array_of_invoices
  customer = engine.customer_repository.find_by_id('21')#######

  assert_equal Array, customer.invoices.class
  assert customer.invoices.all?{|invoice| invoice.class == Invoice}
end

def test_invoices__it_returns_the_correct_invoices
  customer = engine.customer_repository.find_by_id('21')

  invoice_ids = customer.invoices.map {|invoice| invoice.id}
  merchant_ids = customer.invoices.map {|invoice| invoice.merchant_id}

  assert_equal ['109', '110', '111', '112', '113', '114', '115', '116'], invoice_ids
  assert_equal ['96', '45', '72', '71', '18', '44', '87', '80'], merchant_ids
end

def test_invoices__it_returns_an_empty_array_when_no_invoices_are_associated_with_the_customer
  
  input_data = ['9892873429834','Fake','name','0932','09342']
  
  customer = Customer.new(input_data, engine.customer_repository)

  assert_equal [], customer.invoices
end



end
