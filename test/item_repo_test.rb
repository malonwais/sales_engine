require_relative 'test_helper'

class ItemRepoTest < MiniTest::Test

  def test_can_find_invoice_items
    engine = SalesEngine.new
    engine.startup
    engine.invoice_item_repo.map_data(InvoiceItem,'test/fixtures/invoice_items.csv')
    engine.item_repo.map_data(Item,'test/fixtures/items.csv')

    assert_equal 2, engine.item_repo.invoice_items('1').size
  end

  def test_can_find_the_associated_merchant
    engine = SalesEngine.new
    engine.startup
    engine.merchant_repo.map_data(Merchant,'test/fixtures/merchants.csv')
    engine.item_repo.map_data(Item,'test/fixtures/items.csv')

    assert_equal 'Klein, Rempel and Jones', engine.item_repo.merchant('16').name
  end


end
