require_relative 'test_helper'

class TransactionRepoTest < MiniTest::Test

  def test_can_find_invoice
    engine = SalesEngine.new
    engine.startup
    engine.transaction_repo.map_data(Transaction,'test/fixtures/transactions.csv')
    engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')

    assert_equal '26', engine.transaction_repo.invoice('1').merchant_id
  end

end
