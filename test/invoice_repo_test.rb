require_relative 'test_helper'

class InvoiceRepoTest < MiniTest::Test

  def test_returns_transactions_associated_with_an_invoice
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.transaction_repo.map_data(Transaction,'../test/fixtures/transactions.csv')

    assert_equal 2, engine.invoice_repo.transactions('13').size
  end

  def test_returns_invoice_items_associated_with_an_invoice
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.invoice_item_repo.map_data(InvoiceItem,'../test/fixtures/invoice_items.csv')

    assert_equal 4, engine.invoice_repo.invoice_items('2').size
  end

  def test_returns_items_associated_with_an_invoice
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.invoice_item_repo.map_data(InvoiceItem,'../test/fixtures/invoice_items.csv')
    engine.item_repo.map_data(Item,'../test/fixtures/items.csv')
    assert_equal 4, engine.invoice_repo.items('2').size
  end

  def test_returns_correct_customer_id
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.customer_repo.map_data(Customer,'../test/fixtures/customers.csv')

    assert_equal '1', engine.invoice_repo.customer_id('2')
  end

  def test_returns_customer_associated_with_an_invoice
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.customer_repo.map_data(Customer,'../test/fixtures/customers.csv')

    assert_equal 'Joey', engine.invoice_repo.customer('2').first_name
  end

  def test_returns_merchant_id_associated_with_an_invoice
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.merchant_repo.map_data(Merchant,'../test/fixtures/merchants.csv')

    assert_equal '10', engine.invoice_repo.merchant_id('20')
  end

  def test_returns_merchant_associated_with_an_invoice
    engine = SalesEngine.new
    engine.startup
    engine.invoice_repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    engine.merchant_repo.map_data(Merchant,'../test/fixtures/merchants.csv')

    assert_equal 'Bechtelar, Jones and Stokes', engine.invoice_repo.merchant('20').name
  end


end
