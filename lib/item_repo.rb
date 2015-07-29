require_relative 'repo'
require_relative 'item'
class ItemRepo < Repo
  def invoice_items(id)
    @se.invoice_item_repo.table.select do |invoice_item|
      invoice_item.item_id == id
    end
  end

  def merchant(id)
    @se.merchant_repo.table.select do |merchant|
      find_by(:id, id).merchant_id == merchant.id
    end.first
  end
end
