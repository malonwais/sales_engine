require './test_helper'

class RepoTest < MiniTest::Test

  def test_it_initializes_customer_repo_with_data
    engine = SalesEngine.new
    repo = CustomerRepo.new(engine)
    repo.map_data(Customer,'../test/fixtures/customers.csv')
    assert_equal Customer, repo.table[1].class
  end

  def test_it_initializes_transaction_repo_with_data
    engine = SalesEngine.new
    repo = TransactionRepo.new(engine)
    repo.map_data(Transaction,'../test/fixtures/transactions.csv')
    assert_equal Transaction, repo.table[1].class
  end

  def test_it_initializes_invoices_repo_with_data
    engine = SalesEngine.new
    repo = InvoiceRepo.new(engine)
    repo.map_data(Invoice,'../test/fixtures/invoices.csv')
    assert_equal Invoice, repo.table[1].class
  end

  def test_it_initializes_invoice_item_repo_with_data
    engine = SalesEngine.new
    repo = InvoiceItemsRepo.new(engine)
    repo.map_data(InvoiceItem,'../test/fixtures/invoice_items.csv')
    assert_equal InvoiceItem, repo.table[1].class
  end

  def test_it_initializes_merchant_repo_with_data
    engine = SalesEngine.new
    repo = MerchantsRepo.new(engine)
    repo.map_data(Merchant,'../test/fixtures/merchants.csv')
    assert_equal Merchant, repo.table[1].class
  end

  def test_it_initializes_items_repo_with_data
    engine = SalesEngine.new
    repo = ItemsRepo.new(engine)
    repo.map_data(Item,'../test/fixtures/items.csv')
    assert_equal Item, repo.table[1].class
  end

  def test_it_will_return_all_in_table
    engine = SalesEngine.new
    repo = ItemsRepo.new(engine)
    repo.map_data(Item,'../test/fixtures/items.csv')
    assert_equal 20, repo.all.size
  end

  def test_it_returns_a_random_entry
    engine = SalesEngine.new
    repo = ItemsRepo.new(engine)
    repo.map_data(Item,'../test/fixtures/items.csv')
    assert_equal Item, repo.random.class
  end

  def test_it_can_find_by_id_with_FIND_BY
    engine = SalesEngine.new
    engine.startup
    engine.invoice_item_repo.map_data(InvoiceItem,'../test/fixtures/invoice_items.csv')

    assert_equal '1859', engine.invoice_item_repo.find_by(:id,'10').unit_price
  end

  def test_it_can_find_by_first_name
    engine = SalesEngine.new
    engine.startup
    engine.customer_repo.map_data(Customer,'../test/fixtures/customers.csv')

    assert_equal 'Kris', engine.customer_repo.find_by(:first_name,'Logan').last_name
  end

  def test_it_can_find_by_name
    engine = SalesEngine.new
    engine.startup
    engine.merchant_repo.map_data(Merchant,'../test/fixtures/merchants.csv')

    assert_equal '12', engine.merchant_repo.find_by(:name,'Kozey Group').id
  end

  def test_it_can_find_by_unit_price
    engine = SalesEngine.new
    engine.startup
    engine.item_repo.map_data(Item,'../test/fixtures/items.csv')

    assert_equal '4', engine.item_repo.find_by(:unit_price,'4291').id
  end

  def test_it_can_find_by_invoice_id
    engine = SalesEngine.new
    engine.startup
    engine.invoice_item_repo.map_data(InvoiceItem,'../test/fixtures/invoice_items.csv')

    assert_equal '13', engine.invoice_item_repo.find_by(:invoice_id,'3').id
  end

  def test_it_can_find_by_credit_card_number
    engine = SalesEngine.new
    engine.startup
    engine.transaction_repo.map_data(Transaction,'../test/fixtures/transactions.csv')

    assert_equal '1', engine.transaction_repo.find_by(:credit_card_number,'4654405418249630').id
  end

  def test_it_finds_all_by_a_parameter
    engine = SalesEngine.new
    engine.startup
    engine.item_repo.map_data(Item,'../test/fixtures/items.csv')

    assert_equal 15, engine.item_repo.find_all_by(:merchant_id,'1').size
  end



end
