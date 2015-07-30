require_relative 'repo'
require_relative 'invoice'
class InvoiceRepo < Repo

  def transactions(invoice_id)
    repo_table(:transaction_repo).select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def invoice_items(invoice_id)
    repo_table(:invoice_item_repo).select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def items(invoice_id)
    invoice_items(invoice_id).each do |invoice_item|
      repo_table(:item_repo).select do |item|
        invoice_item.item_id == item.id
      end
    end
  end

  def customer(invoice_id)
    repo_table(:customer_repo).find do |customer|
      find_by(:id, invoice_id).customer_id == customer.id
    end
  end

  def merchant(invoice_id)
    repo_table(:merchant_repo).find do |merchant|
      find_by(:id, invoice_id).merchant_id == merchant.id
    end
  end

end
