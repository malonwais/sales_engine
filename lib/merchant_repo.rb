require_relative 'repo'
require_relative 'merchant'
class MerchantRepository < Repo
  
  attr_reader :se, :table , :hash
  
  def initialize(sales_engine)
    @se = sales_engine
    @table = []
    
    map_data(Merchant,'../sales_engine/data/merchants.csv')
    @hash = populate_hash(@table)
  end
  def populate_hash(table)
    output = Hash.new({})
    table.reverse!
    table.each do |record|
      # puts record.id
      output[:id][record.id] = record
      output[:name][record.name] = record
      output[:created_at][record.created_at] = record
      output[:updated_at][record.updated_at] = record
      
    end
  end

  
  
  
  
  def most_revenue(merchant_count)
    start =   Time.now
    top_merchants(merchant_count, ranked_merchants(revenue_list))
  end
  
  def most_items(merchant_count)
    start = Time.now
    result = top_merchants(merchant_count, ranked_merchants(quantity_sold_list))
    puts Time.now - start
    result
  end
  
  def revenue(date)
    invoice_items = se.invoice_item_repository.find_all_by_date(:created_at, date)
    invoice_items.reduce(0) do |sum, invoice_item|
      sum + invoice_item.revenue
    end
  end
  
  def ranked_merchants(merchant_list)
    merchant_list.sort_by do |merchant, quantity|
      quantity
    end.reverse!
  end
  
  def top_merchants(count, merchants)
    merchants[0..count - 1].map do |merchant_rank|
      find_by_id(merchant_rank.first)
    end
  end
  
  def revenue_list
    
    invoice_item_repo = se.invoice_item_repository
    item_revenue_by_invoice = invoice_item_repo.item_data_by_invoice(:simple_revenue)
    revenue_by_merchant(item_revenue_by_invoice)
    
  end
  def revenue_by_merchant(item_revenue_by_invoice)
    output = Hash.new(0)
    item_revenue_by_invoice.each do |invoice_id, item_revenues|
      invoice = se.invoice_repository.find_by_id(invoice_id)
      if invoice.successful?
        item_revenues.each do |item_id, revenue|
          output[invoice.merchant_id] += revenue
        end
      end
    end
    output
  end
  
  def quantity_sold_list
    grouped_quantity_sold = Hash.new(0)
    se.invoice_item_repository.all.each do |invoice_item|
      merchant = invoice_item.merchant
      quantity = invoice_item.quantity
      grouped_quantity_sold[merchant] += quantity.to_i if invoice_item.successful?
    end
    grouped_quantity_sold
  end
  
  
  
  
  
  
  
  # def group_invoices_with_merchant
  #   repo_table(:invoice_repo).group_by do |invoice|
  #     invoice.merchant_id
  #   end
  # end
  #
  # def group_merchant_with_invoice_ids(hash)
  #   Hash[hash.map do |merch, invoices|
  #     [merch, invoices.map {|invoice| invoice.id}]
  #   end]
  # end
  #returns hash of invoice_id's pointing to collections of invoice items
  #  def group_invoice_items_with_invoice
  #    repo_table(:invoice_item_repo).group_by do |invoice_item|
  #      invoice_item.invoice_id
  #    end
  #  end
  
  # def total_inv_item_price(i_item)
  #   i_item.unit_price.to_i * i_item.quantity.to_i
  # end
  #
  # def array_of_inv_item_prices(array)
  #   array.map {|item| total_inv_item_price(item)}
  # end
  #
  #           def inv_to_inv_item_prices(inv_to_inv_items)
  #             Hash[inv_to_inv_items.map do |inv, inv_item_array|
  #               [inv, array_of_inv_item_prices(inv_item_array) ]
  #             end]
  #           end
  #
  # def map_merchants_to_invoice_prices(merch_hash, invoice_price_hash)
  #   Hash[merch_hash.map do |merch_id, invoice_ids|
  #     [merch_id, invoice_ids.map {|id| invoice_price_hash[id] ||= 0 }]
  #   end]
  # end
  #
  # def add_array_in_hash(hash)
  #   Hash[hash.map do |key, array_of_things|
  #     [key, array_of_things.inject(:+)]
  #   end]
  # end
  #
  # def most_revenue(top_x)
  # sep_prices = inv_to_inv_item_prices(group_invoice_items_with_invoice)
  # total_inv_price = add_array_in_hash(sep_prices)
  # merch_with_ids = group_merchant_with_invoice_ids(group_invoices_with_merchant)
  # merch_with_spends = map_merchants_to_invoice_prices(merch_with_ids, total_inv_price)
  # total_spends_per_merch = add_array_in_hash(merch_with_spends)
  # merch_spend = []
  # total_spends_per_merch.each do |merch, spend|
  # merch_spend << [merch, spend]
  # end
  # merch_spend.sort_by {|a| a[1]}.last(top_x).reverse
  # end
  #
  # def inv_item_quantities(array)
  #   array.map { |item| item.quantity }
  # end
  #
  # def invoice_item_quantity_with_invoice(inv_with_inv_itmes)
  #   Hash[inv_with_inv_itmes.map do |inv_id, inv_items|
  #     [inv_id, inv_item_quantities(inv_items)]
  #   end]
  # end
  #
  # def most_items(top_x)
  #   group_merchant_with_invoice_ids(group_invoices_with_merchant)
  #
  #   group_invoice_items_with_invoice
  #
  # end
  
  
  
  
end
