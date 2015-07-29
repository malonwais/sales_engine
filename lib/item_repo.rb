require_relative 'repo'
require_relative 'item'
class ItemRepo < Repo
  def invoice_items(item_id)
    @se.invoice_item_repo.table.select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def merchant(item_id)
    @se.merchant_repo.table.find do |merchant|
      find_by(:id, item_id).merchant_id == merchant.id
    end
  end
end
