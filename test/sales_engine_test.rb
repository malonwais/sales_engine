require './test_helper'


class SalesEngineTest < MiniTest::Test

  def test_it_starts_up_a_new_sales_engine
    engine = SalesEngine.new
    engine.startup
    assert_equal CustomerRepo, engine.customer_repo.class
    assert_equal InvoiceRepo, engine.invoice_repo.class
    assert_equal TransactionRepo, engine.transaction_repo.class
    assert_equal InvoiceItemsRepo, engine.invoice_items_repo.class
    assert_equal MerchantsRepo, engine.merchants_repo.class
    assert_equal ItemsRepo, engine.items_repo.class
    assert_equal engine, engine.customer_repo.se
    assert_equal engine, engine.merchants_repo.se
  end

end
