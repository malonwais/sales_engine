require_relative 'test_helper'

class InvoiceRepoTest < MiniTest::Test

    @@engine = SalesEngine.new
    @@engine.startup

    def engine
      @@engine
    end

    def test_transactions__it_gets_an_array_of_them
      invoice = engine.invoice_repo.find_by(:id, '12')

      assert_equal Array, invoice.transactions.class
      assert invoice.transactions.all?{|transaction| transaction.class == Transaction}
    end

    def test_transactions__it_gets_the_correct_ones
      invoice = engine.invoice_repo.find_by(:id, '12')
      transaction_ids = invoice.transactions.map {|transaction| transaction.id}
      cc_numbers = invoice.transactions.map {|transaction| transaction.credit_card_number}

      assert_equal ['11', '12', '13'], transaction_ids
    	assert_equal ['4800749911485986', '4017503416578382', '4536896898764278'], cc_numbers
    end

    def test_transactions__it_returns_an_empty_array_when_no_transactions_are_associated_with_the_invoice
      input_data = ['23dfsdf4234', '246sdf11234234', '234sdf4234', 'success', '12342sdf4234', '234sdf234']
      invoice = Invoice.new(input_data, engine.invoice_repo)
      

      assert_equal [], invoice.transactions
    end

    def test_invoice_items__it_gets_an_array_of_them
      invoice = engine.invoice_repo.find_by(:id, '12')

      assert_equal Array, invoice.invoice_items.class
      assert invoice.invoice_items.all?{|invoice_item| invoice_item.class == InvoiceItem}
    end

    def test_invoice_items__it_gets_the_correct_ones
      invoice = engine.invoice_repo.find_by(:id, '12')
      invoice_item_ids = invoice.invoice_items.map {|invoice_item| invoice_item.id}
      item_prices = invoice.invoice_items.map {|invoice_item| invoice_item.unit_price}

      assert_equal ['56', '57', '58', '59', '60', '61'], invoice_item_ids
      assert_equal ['78031', '41702', '71340', '7196', '41702', '22546'], item_prices
    end

    def test_invoice_items__it_returns_an_empty_array_when_no_invoice_items_are_associated_with_the_invoice

      input_data = ['23dfsdf4234', '246sdf11234234', '234sdf4234', 'success', '12342sdf4234', '234sdf234']
      invoice = Invoice.new(input_data, engine.invoice_repo)


      assert_equal [], invoice.invoice_items
    end

    def test_items__it_gets_an_array_of_items
      invoice = engine.invoice_repo.find_by(:id, '12')

      assert_equal Array, invoice.items.class
      assert invoice.items.all?{|item| item.class == Item}

    end

    def test_items__it_gets_the_correct_items
      invoice = engine.invoice_repo.find_by(:id, '12')
      item_ids = invoice.items.map {|item| item.id}
      item_prices = invoice.items.map {|item| item.unit_price}

      assert_equal ['150', '127', '156', '160', '134'], item_ids
      assert_equal ['78031', '41702', '71340', '7196', '22546'], item_prices
    end

    def test_items__it_returns_an_empty_array_when_no_items_are_associated_with_the_invoice
      input_data = ['23dfsdf4234', '246sdf11234234', '234sdf4234', 'success', '12342sdf4234', '234sdf234']
      invoice = Invoice.new(input_data, engine.invoice_repo)

      assert_equal [], invoice.items
    end

    def test_customer__it_can_pull_a_customer
      invoice = engine.invoice_repo.find_by(:id, '12')
      assert_equal Customer, invoice.customer.class
    end

    def test_customer__it_pulls_the_correct_customer
      invoice = engine.invoice_repo.find_by(:id, '12')

      assert_equal "Mariah", invoice.customer.first_name
    end

    def test_merchant__it_can_pull_a_merchant
      invoice = engine.invoice_repo.find_by(:id, '12')

      assert_equal Merchant, invoice.merchant.class
    end

    def test_merchant__it_pulls_the_correct_merchant
      invoice = engine.invoice_repo.find_by(:id, '12')

      assert_equal "Osinski, Pollich and Koelpin", invoice.merchant.name
    end
    def test__revenue__it_returns_0_when_the_invoice_doesnt_have_a_cooresponding_transaction
      #we have made $0 from a invoice that has no transaction
      input_data = ['2132123','2412312312','2312314123','shipped','81231','123144']
      invoice = Invoice.new(input_data, engine.invoice_repo)
      
      assert_equal 0, invoice.revenue
    end
    def test__revenue__it_returns_a_big_decimal_when_given_a_valid_invoice
      invoice = engine.invoice_repo.find_by(:id, '12')
      assert_equal BigDecimal, invoice.revenue.class
    end
    
    def test__revenue__it_returns_the_correct_revenue
      @id = input_data[0]
      @invoice_id = input_data[1]
      @credit_card_number = input_data[2]
      @credit_card_expiration_date = input_data[3]
      @result = input_data[4]
      @created_at = input_data[5]
      @updated_at = input_data[5]
      @transaction_repository = transaction_repository
      transaction1 = ['999997','23232323','098123098123',]
      
      
      input_data = ['23232323','2412312312','2312314123','shipped','81231','123144']
      invoice = Invoice.new(input_data, engine.invoice_repo)
      
      assert_equal BigDecimal, invoice.revenue
    end

end
