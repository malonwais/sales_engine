require_relative 'customer_repo'
require_relative 'invoice_repo'
require_relative 'transaction_repo'
require_relative 'invoice_item_repo'
require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'repo'
require 'pry'


class SalesEngine
  attr_reader :customer_repository, :invoice_repo, :transaction_repo,
  :invoice_item_repo, :merchant_repo, :item_repo
  
  def initialize(thing1=0, thing2=0)
    
  end

  def repo_startup
    @customer_repository = CustomerRepository.new(self)
    @invoice_repo = InvoiceRepo.new(self)
    @transaction_repo = TransactionRepo.new(self)
    @invoice_item_repo = InvoiceItemRepo.new(self)
    @merchant_repo = MerchantRepo.new(self)
    @item_repo = ItemRepo.new(self)
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
