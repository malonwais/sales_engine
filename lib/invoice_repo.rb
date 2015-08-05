require_relative 'repo'
require_relative 'invoice'
class InvoiceRepository < Repo

  attr_reader :se, :table, :hash

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Invoice,'../sales_engine/data/invoices.csv')
    @hash = populate_hash(@table)
  end

  def create(invoice_info)
    customer_id = invoice_info[:customer].id
    merchant_id = invoice_info[:merchant].id
    status = invoice_info[:status]
    created_at = Time.now.utc.to_s
    updated_at = created_at
    items = invoice_info[:items]
    new_id = table[-1].id + 1

    new_record = [new_id, customer_id, merchant_id, status, created_at, updated_at]
    new_invoice = Invoice.new(new_record, self)
    table << new_invoice
    hash = populate_hash(table)

    se.invoice_item_repository.add_invoice_items(items, new_id)

    new_invoice
  end

end
