require_relative 'test_helper'

class InvoiceItemTest < MiniTest::Test

  @@engine = SalesEngine.new
  @@engine.startup

  def engine
    @@engine
  end

  def test_it_can_pull_an_invoice
    invoice_item = engine.invoice_item_repo.find_by(:id, '13')

    assert_equal Invoice, invoice_item.invoice.class
  end

  def test_it_pulls_the_correct_invoice
    invoice_item = engine.invoice_item_repo.find_by(:id, '13')

    assert_equal '3', invoice_item.invoice.id
  	assert_equal '78', invoice_item.invoice.merchant_id
  end

    def test_it_returns_nil_when_invoice_is_not_found
      invoice_item = engine.invoice_item_repo.find_by(:id, '4521')

      assert_nil invoice_item.invoice
    end

  def test_it_can_pull_an_item
    invoice_item = engine.invoice_item_repo.find_by(:id, '8')

    assert_equal Item, invoice_item.item.class
  end

  def test_it_pulls_the_correct_item
    invoice_item = engine.invoice_item_repo.find_by(:id, '8')

    assert_equal '534', invoice_item.item.id
    assert_equal '76941', invoice_item.item.unit_price
  end

  def test_it_returns_nil_when_item_is_not_found
    invoice_item = engine.invoice_item_repo.find_by(:id, '13')

    assert_nil invoice_item.item
  end







  # def test_returns_invoice_associated_with_an_invoice_item
  #   engine = SalesEngine.new
  #   engine.startup
  #   engine.invoice_item_repo.map_data(InvoiceItem,'test/fixtures/invoice_items.csv')
  #   engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')
  #
  #   assert_equal '75', engine.invoice_item_repo.invoice('10').merchant_id
  # end
  #
  # def test_returns_item_associated_with_an_invoice_item
  #
  #   engine = SalesEngine.new
  #   engine.startup
  #   engine.invoice_item_repo.map_data(InvoiceItem,'test/fixtures/invoice_items.csv')
  #   engine.item_repo.map_data(Item,'test/fixtures/items.csv')
  #
  #   assert_equal '34018', engine.invoice_item_repo.item('10').unit_price
  # binding.pry
  # end


end
