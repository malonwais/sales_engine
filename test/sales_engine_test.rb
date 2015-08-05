require_relative 'test_helper'


class SalesEngineTest < MiniTest::Test

  def test_it_starts_up_a_new_sales_engine
    engine = SalesEngine.new
    engine.startup
    assert_equal CustomerRepository, engine.customer_repository.class
    assert_equal InvoiceRepository, engine.invoice_repository.class
    assert_equal TransactionRepository, engine.transaction_repository.class
    assert_equal InvoiceItemRepository, engine.invoice_item_repository.class
    assert_equal MerchantRepository, engine.merchant_repository.class
    assert_equal ItemRepository, engine.item_repository.class
    assert_equal engine, engine.customer_repository.se
    assert_equal engine, engine.merchant_repository.se
  end

end
