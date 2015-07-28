require_relative 'customer_repo'
require_relative 'invoice_repo'
require_relative 'transaction_repo'
require_relative 'invoice_items_repo'
require_relative 'merchants_repo'
require_relative 'items_repo'
require_relative 'repo'

class SalesEngine
  attr_reader :customer_repo, :invoice_repo, :transaction_repo,
    :invoice_item_repo, :merchant_repo, :item_repo

  def startup
    @customer_repo = CustomerRepo.new(self)
    @invoice_repo = InvoiceRepo.new(self)
    @transaction_repo = TransactionRepo.new(self)
    @invoice_item_repo = InvoiceItemsRepo.new(self)
    @merchant_repo = MerchantsRepo.new(self)
    @item_repo = ItemsRepo.new(self)
  end

  def map_all_data

  end

end

#
# engine = SalesEngine.new
# engine.startup
