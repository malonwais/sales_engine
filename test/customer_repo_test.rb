require_relative 'test_helper'

class CustomerRepoTest < MiniTest::Test

  def test_can_find_invoices
    engine = SalesEngine.new
    engine.startup
    engine.customer_repo.map_data(Customer,'test/fixtures/customers.csv')
    engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')

    assert_equal 8, engine.customer_repo.invoices('1').size
  end

end
