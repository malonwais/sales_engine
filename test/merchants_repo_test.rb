require_relative 'test_helper'

class MerchantRepoTest < MiniTest::Test

  def test_returns_items_associated_with_a_merchant
    engine = SalesEngine.new
    engine.startup
    engine.merchant_repo.map_data(Merchant,'test/fixtures/merchants.csv')
    engine.item_repo.map_data(Item,'test/fixtures/items.csv')

    assert_equal 5, engine.merchant_repo.items('2').size
  end

  def test_returns_invoices_associated_with_a_merchant
    engine = SalesEngine.new
    engine.startup
    engine.merchant_repo.map_data(Merchant,'test/fixtures/merchants.csv')
    engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')

    assert_equal 2, engine.merchant_repo.invoices('44').size
  end

end
