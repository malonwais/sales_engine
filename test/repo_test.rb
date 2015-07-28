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

end
