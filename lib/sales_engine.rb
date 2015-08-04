require_relative 'customer_repo'
require_relative 'invoice_repo'
require_relative 'transaction_repo'
require_relative 'invoice_item_repo'
require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'repo'
require 'pry'


class SalesEngine
  attr_reader :customer_repository, :invoice_repository, :transaction_repository,
  :invoice_item_repository, :merchant_repository, :item_repository
  
  def initialize(thing1=0, thing2=0)
    
  end

  def repo_startup
    @customer_repository = CustomerRepository.new(self)
    @invoice_repository = InvoiceRepository.new(self)
    @transaction_repository = TransactionRepository.new(self)
    @invoice_item_repository = InvoiceItemRepository.new(self)
    @merchant_repository = MerchantRepository.new(self)
    @item_repository = ItemRepository.new(self)
  end

  def intel_startup
    MerchantRepoIntel.new(self)
  end

  def startup
    repo_startup
    # intel_startup
  end

end

engine = SalesEngine.new()
engine.startup
if __FILE__ == $0
  binding.pry
end
