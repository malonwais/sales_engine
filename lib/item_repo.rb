require_relative 'repo'
require_relative 'item'
class ItemRepo < Repo
  def invoice_items(item_id)
    repo_table(:invoice_item_repo).select do |invoice_item|
      invoice_item.item_id == item_id
    end
  end

  def merchant(item_id)
    repo_table(:merchant_repo).find do |merchant|
      find_by(:id, item_id).merchant_id == merchant.id
    end
  end
end
