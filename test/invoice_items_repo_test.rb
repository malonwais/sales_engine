require_relative 'test_helper'

class InvoiceItemRepoTest < MiniTest::Test


  def test_returns_invoice_associated_with_an_invoice_item
    engine = SalesEngine.new
    engine.startup
    engine.invoice_item_repo.map_data(InvoiceItem,'test/fixtures/invoice_items.csv')
    engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')

    assert_equal '75', engine.invoice_item_repo.invoice('10').merchant_id
  end

  def test_returns_item_associated_with_an_invoice_item

    engine = SalesEngine.new
    engine.startup
    engine.invoice_item_repo.map_data(InvoiceItem,'test/fixtures/invoice_items.csv')
    engine.item_repo.map_data(Item,'test/fixtures/items.csv')

    assert_equal '34018', engine.invoice_item_repo.item('10').unit_price
  end


end
