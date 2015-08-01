require_relative 'test_helper'

class TransactionRepoTest < MiniTest::Test


  @@engine = SalesEngine.new
    @@engine.startup

    def engine
      @@engine
    end

    def test_invoice__it_can_pull_an_invoice
      transaction = engine.transaction_repo.find_by(:id, '3')

      assert_equal Invoice, transaction.invoice.class
    end

    def test_merchant__it_pulls_the_correct_invoice
      transaction = engine.transaction_repo.find_by(:id, '3')

      assert_equal '4', transaction.invoice.id
      assert_equal '33', transaction.invoice.merchant_id
    end



  # def test_can_find_invoice
  #   engine = SalesEngine.new
  #   engine.startup
  #   engine.transaction_repo.map_data(Transaction,'test/fixtures/transactions.csv')
  #   engine.invoice_repo.map_data(Invoice,'test/fixtures/invoices.csv')
  #
  #   assert_equal '26', engine.transaction_repo.invoice('1').merchant_id
  # end

end
