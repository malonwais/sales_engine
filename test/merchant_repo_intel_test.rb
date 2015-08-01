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
    intel = MerchantRepoIntel.new(engine)
    result = intel.group_invoices_with_merchant['44']

    assert_equal 2, result.size
  end

  def test_can_group_merchant_with_invoice_id
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)
    int = intel.group_invoices_with_merchant
    result = intel.group_merchant_with_invoice_ids(int)

    assert_equal ['7','14'], result['44']
  end


  def test_can_group_invoice_items_by_merchant
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)
    result = intel.group_invoice_items_with_invoice['2']

    assert_equal 4, result.size
  end

  def test_can_calulate_toal_price
    engine = SalesEngine.new
    engine.startup
    item = InvoiceItem.new([1,2,3,'4','5',5,6])
    intel = MerchantRepoIntel.new(engine)
    result = intel.total_inv_item_price(item)

    assert_equal 20, result
  end

  def test_can_calulate_toal_price_of_an_array
    engine = SalesEngine.new
    engine.startup
    item1 = InvoiceItem.new([1,2,3,'4','5',5,6])
    item2 = InvoiceItem.new([1,2,3,'5','6',5,6])
    intel = MerchantRepoIntel.new(engine)

    result = intel.array_of_inv_item_prices([item1, item2])

    assert_equal 30, result[1]
  end


  def test_can_find_total_inv_item_prices_for_an_invoice
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)
    inv_items = intel.group_invoice_items_with_invoice
    result = intel.inv_to_inv_item_prices(inv_items)

    assert_equal 68175, result['1'].first
  end

  def test_can_find_total_invoice_price
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)
    inv_items = intel.group_invoice_items_with_invoice
    sep_prices = intel.inv_to_inv_item_prices(inv_items)
    total_inv_price = intel.add_array_in_hash(sep_prices)

    assert_equal 2106777, total_inv_price['1']
  end

  def test_can_map_merch_to_invoice_prices
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)

    inv_items = intel.group_invoice_items_with_invoice
    sep_prices = intel.inv_to_inv_item_prices(inv_items)
    total_inv_price = intel.add_array_in_hash(sep_prices)

    int = intel.group_invoices_with_merchant
    merch_with_ids = intel.group_merchant_with_invoice_ids(int)
    result = intel.map_merchants_to_invoice_prices(merch_with_ids, total_inv_price)
    assert_equal 2106777, result['26'].first
  end

  def test_can_find_total_spend_per_merchant
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)

    inv_items = intel.group_invoice_items_with_invoice
    sep_prices = intel.inv_to_inv_item_prices(inv_items)
    total_inv_price = intel.add_array_in_hash(sep_prices)

    int = intel.group_invoices_with_merchant
    merch_with_ids = intel.group_merchant_with_invoice_ids(int)
    merch_with_spends = intel.map_merchants_to_invoice_prices(merch_with_ids, total_inv_price)
    result = intel.add_array_in_hash(merch_with_spends)

    assert_equal 2106777, result['26']
  end

  def test_can_find_top_x_merch_by_revenue
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)

    result = intel.most_revenue(2)
    assert_equal [["78", 2367699], ["26", 2106777]], result
  end

  def test_can_convert_i_items_to_quantities
    engine = SalesEngine.new
    engine.startup
    item1 = InvoiceItem.new([1,2,3,'4','5',5,6])
    item2 = InvoiceItem.new([1,2,3,'5','6',5,6])
    intel = MerchantRepoIntel.new(engine)
    result = intel.inv_item_quantities([item1, item2])

    assert_equal ['4','5'], result
  end

  def test_can_map_inv_item_quantities_to_invoice_id
    engine = SalesEngine.new
    engine.startup
    intel = MerchantRepoIntel.new(engine)

    inv_items = intel.group_invoice_items_with_invoice
    sep_prices = intel.invoice_item_quantity_with_invoice(inv_items)
    total_inv_price = intel.add_array_in_hash(sep_prices)

    int = intel.group_invoices_with_merchant
    merch_with_ids = intel.group_merchant_with_invoice_ids(int)
    merch_with_spends = intel.map_merchants_to_invoice_prices(merch_with_ids, total_inv_price)
    result = intel.add_array_in_hash(merch_with_spends)

  end




end
