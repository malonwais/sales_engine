require_relative 'test_helper'

class MerchantRepoIntelTest < MiniTest::Test

  def test_it_initializes_a_new_merchant_intel
    sales = SalesEngine.new
    a = MerchantRepoIntel.new(sales)

    assert_equal sales, a.se
  end

  def test_can_group_invoices_by_merchant
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')
    intel = MerchantRepoIntel.new(engine)
    result = intel.group_invoices_with_merchant['44']

    assert_equal 2, result.size
  end

  def test_can_group_invoice_items_by_merchant
    engine = SalesEngine.new
    engine.startup
    engine.invoice_item_repo.map_data(InvoiceItem,'test/fixtures/invoice_items.csv')
    intel = MerchantRepoIntel.new(engine)
    result = intel.group_invoice_items_with_invoice['2']

    assert_equal 4, result.size
  end



end
