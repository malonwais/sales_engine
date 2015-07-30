require_relative 'repo'
require_relative 'merchant'
class MerchantRepo < Repo

  def items(merchant_id)
    repo_table(:item_repo).select do |item|
      item.merchant_id == merchant_id
    end
  end

  def invoices(merchant_id)
    repo_table(:invoice_repo).select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

end
