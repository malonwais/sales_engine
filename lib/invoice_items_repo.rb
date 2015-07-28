require_relative 'repo'
require_relative 'invoice_item'
class InvoiceItemsRepo < Repo

  invoice returns an instance of Invoice associated with this object
  item returns an instance of Item associated with this object

  def invoice_id(invoice_item_id)
    self.table.select do |invoiceitem|
      invoiceitem.id == invoice_item_id
    end.first.invoice_id
  end

  # def invoice(invoice_id)
  #   @se.customer_repo.table.select do |customer|
  #     customer_id(invoice_id) == customer.id
  #   end.first
  # end


end
