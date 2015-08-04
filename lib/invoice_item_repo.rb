require_relative 'repo'
require_relative 'invoice_item'

class InvoiceItemRepository < Repo
  attr_reader :se, :table, :invoice_items

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    @invoice_items =  @table
    map_data(InvoiceItem,'../sales_engine/data/invoice_items.csv')
  end
  
  def item_data_by_invoice(method_name)
    output_hash = {}
    
    se.invoice_item_repository.table.each do |invoice_item|
      invoice_id = invoice_item.invoice_id
      item_id = invoice_item.item_id
      data = invoice_item.send(method_name)
      output_hash[invoice_id] ||= {}
      
      if output_hash[invoice_id][item_id].nil?
        output_hash[invoice_id][item_id] = data
      else
        output_hash[invoice_id][item_id] += data
      end
      
    end
    output_hash
  end
  
  
  def items_values(data_by_invoice)
    output = {}
    data_by_invoice.each do |invoice_id, items_with_values|
      invoice = se.invoice_repository.find_by_id(invoice_id)
      if invoice.successful?
        items_with_values.each do |item_id, value|
          if output[item_id].nil?
            output[item_id] = value
          else
            output[item_id] += value
          end
        end
        
      end
    end
    output
    
  end



end
