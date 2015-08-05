require_relative 'repository'
require_relative 'item'
class ItemRepository < Repository

  attr_reader :se, :table, :quick_lookup_table

  def initialize(sales_engine, csv_path)
    @se = sales_engine
    @table = []
    map_data(Item,File.join(csv_path, "items.csv"))
    @quick_lookup_table = populate_quick_lookup_table(@table)
  end

  def most_revenue(item_count)

    invoice_items = se.invoice_item_repository
    revenue = invoice_items.item_data_by_invoice(:simple_revenue)
    item_revenue_by_invoice = revenue
    items_by_revenue = invoice_items.items_values(item_revenue_by_invoice)

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
    invoice_items = se.invoice_item_repository
    item_quantity_by_invoice = ivoice_items.item_data_by_invoice(:quantity)
    items_by_quantity = ivoice_items.items_values(item_quantity_by_invoice)

    items_by_quantity = items_by_quantity.sort_by do |item,quantity|
      quantity
    end
    items_by_quantity.reverse!
    top_items = items_by_quantity[0..item_count-1].map do |item_id, quantity|
      find_by_id(item_id)
    end
  end

end
