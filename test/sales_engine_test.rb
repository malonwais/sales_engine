require_relative 'test_helper'


class SalesEngineTest < MiniTest::Test

  def test_it_starts_up_a_new_sales_engine
    engine = SalesEngine.new
    engine.startup
    assert_equal CustomerRepository, engine.customer_repository.class
    assert_equal InvoiceRepo, engine.invoice_repo.class
    assert_equal TransactionRepo, engine.transaction_repo.class
    assert_equal InvoiceItemRepo, engine.invoice_item_repo.class
    assert_equal MerchantRepo, engine.merchant_repo.class
    assert_equal ItemRepo, engine.item_repo.class
    assert_equal engine, engine.customer_repository.se
    assert_equal engine, engine.merchant_repo.se
  end

end
