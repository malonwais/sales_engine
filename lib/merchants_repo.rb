require_relative 'repo'
require_relative 'merchant'
class MerchantsRepo < Repo

  def items(merchant_id)
    @se.item_repo.table.select do |item|
      item.merchant_id == merchant_id
    end
  end

  def invoices(merchant_id)
    @se.invoice_repo.table.select do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

end
