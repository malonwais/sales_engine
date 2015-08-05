require_relative 'repository'
require_relative 'merchant'
class MerchantRepository < Repository

  attr_reader :se, :table , :quick_lookup_table

  def initialize(sales_engine, csv_path)
    @se = sales_engine
    @table = []

    map_data(Merchant,'../sales_engine/data/merchants.csv')
    @quick_lookup_table = populate_quick_lookup_table(@table)
  end

  def most_revenue(merchant_count)
    top_merchants(merchant_count, ranked_merchants(revenue_list))
  end

  def most_items(merchant_count)
    top_merchants(merchant_count, ranked_merchants(quantity_sold_list))
  end

  def revenue(date)
    date = good_date(date)
    total = 0

    revenue_by_invoice.each do |invoice_id, revenue|
      invoice = se.invoice_repository.find_by(:id, invoice_id)
      if invoice.successful? && good_date(invoice.created_at) == date
          total += revenue
      end
    end
    total * 0.01
  end

  def revenue_by_invoice
    invoices = Hash.new(0)
    se.invoice_item_repository.all.each do |invoice_item|
      invoice_id = invoice_item.invoice_id
      invoices[invoice_id] += invoice_item.simple_revenue
    end
    invoices
  end

  def ranked_merchants(merchant_list)
    merchant_list.sort_by{|merchant, quantity| quantity}.reverse
  end

  def top_merchants(count, merchants)
    merchants[0..count - 1].map{|merchant_rank| find_by_id(merchant_rank.first)}
  end

  def revenue_list
    invoice_item_repository = se.invoice_item_repository
    item_revenue_by_invoice = invoice_item_repository.item_data_by_invoice(:simple_revenue)
    data_by_merchant(item_revenue_by_invoice)
  end

  def quantity_sold_list
    invoice_item_repository = se.invoice_item_repository
    item_quantity_by_invoice = invoice_item_repository.item_data_by_invoice(:quantity)
    data_by_merchant(item_quantity_by_invoice)
  end

  def data_by_merchant(item_data_by_invoice)
    output = Hash.new(0)
    item_data_by_invoice.each do |invoice_id, item_data|
      invoice = se.invoice_repository.find_by_id(invoice_id)
      if invoice.successful?
        item_data.each {|item_id, data| output[invoice.merchant_id] += data}
      end
    end
    output
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
