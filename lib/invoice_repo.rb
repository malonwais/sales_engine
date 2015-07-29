require_relative 'repo'
require_relative 'invoice'
class InvoiceRepo < Repo

  def transactions(invoice_id)
    @se.transaction_repo.table.select do |transaction|
      transaction.invoice_id == invoice_id
    end
  end

  def invoice_items(invoice_id)
    @se.invoice_item_repo.table.select do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def items(invoice_id)
    invoice_items(invoice_id).each do |invoice_item|
      @se.item_repo.table.select do |item|
        invoice_item.item_id == item.id
      end
    end
  end

  def customer(invoice_id)
    @se.customer_repo.table.select do |customer|
      find_by_id(invoice_id).customer_id == customer.id
    end.first
  end

  def merchant(invoice_id)
    @se.merchant_repo.table.select do |merchant|
      find_by_id(invoice_id).merchant_id == merchant.id
    end.first
  end

end
