require_relative 'repo'
require_relative 'item'
class ItemRepository < Repo

  attr_reader :se, :table, :hash

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    map_data(Item,'../sales_engine/data/items.csv')
    @hash = populate_hash(@table)
  end

  def most_revenue(item_count)

    invoice_item_repo = se.invoice_item_repository
    item_revenue_by_invoice = invoice_item_repo.item_data_by_invoice(:simple_revenue)
    items_by_revenue = invoice_item_repo.items_values(item_revenue_by_invoice)

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
    invoice_item_repo = se.invoice_item_repository
    item_quantity_by_invoice = invoice_item_repo.item_data_by_invoice(:quantity)
    items_by_quantity = invoice_item_repo.items_values(item_quantity_by_invoice)

    items_by_quantity = items_by_quantity.sort_by do |item,quantity|
      quantity
    end
    items_by_quantity.reverse!
    top_items = items_by_quantity[0..item_count-1].map do |item_id, quantity|
      find_by_id(item_id)
    end

  end



end
