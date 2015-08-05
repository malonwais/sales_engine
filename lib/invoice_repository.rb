require_relative 'repository'
require_relative 'invoice'
class InvoiceRepository < Repository

  attr_reader :se, :table, :quick_lookup_table

  def initialize(sales_engine, csv_path)
    @se = sales_engine
    @table = []
    map_data(Invoice,'../sales_engine/data/invoices.csv')
    @quick_lookup_table = populate_quick_lookup_table(@table)
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
    @quick_lookup_table = populate_quick_lookup_table(table)

    se.invoice_item_repository.add_invoice_items(items, new_id)

    new_invoice
  end

end
