require_relative 'repo'
require_relative 'item'
class ItemRepository < Repo
  
  attr_reader :se, :table
  
  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Item,'../sales_engine/data/items.csv')
  end
  
  def most_revenue(item_count)

    
    item_revenue_by_invoice = item_data_by_invoice(:simple_revenue)
    items_by_revenue = items_values(item_revenue_by_invoice)
    
    items_by_revenue = items_by_revenue.sort_by do |item,revenue|
      revenue
    end
    items_by_revenue.reverse!
    top_items = items_by_revenue[0..item_count-1].map do |item_id, revenue|
      find_by_id(item_id)
    end
    top_items

  
  end
  def most_items(item_count)
    item_quantity_by_invoice = item_data_by_invoice(:quantity)
    items_by_quantity = items_values(item_quantity_by_invoice)
    
    items_by_quantity = items_by_quantity.sort_by do |item,quantity|
      quantity
    end
    items_by_quantity.reverse!
    top_items = items_by_quantity[0..item_count-1].map do |item_id, quantity|
      find_by_id(item_id)
    end
    
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
