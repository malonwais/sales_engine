class Item
  attr_reader :id, :name, :description, :unit_price, :merchant_id, :created_at,
              :updated_at, :item_repository, :args

  def initialize(input_data, item_repository)
    @id = input_data[0].to_i
    @name = input_data[1]
    @description = input_data[2]
    @unit_price = BigDecimal.new(input_data[3])
    @merchant_id = input_data[4].to_i
    @created_at = input_data[5]
    @updated_at = input_data[6]
    @item_repository = item_repository
    @args = [:id, :name, :description, :unit_price, :merchant_id, :created_at,
                :updated_at]
  end

  def invoice_items
    item_repository.se.invoice_item_repository.find_all_by_item_id(id)
  end

  def merchant
    item_repository.se.merchant_repository.find_by(:id, merchant_id)

  end
  def best_day(invoice_date)
    invoice_ids = engine.invoice_item_repository.item_data_by_invoice(:simple_revenue)
    dates = {}
    invoice_ids.each do |invoice_id, revenues|
      if item_repository.se.invoice_repository.find_by(:id, invoice_id).successful?

        revenues.reduce


      end

    end


    dates = group.group_by do |invoice_id,data|
      invoice = engine.invoice_repository.find_by(:id, invoice_id)
      invoice.invoice_repository.good_date(invoice.created_at)
    end



  end
  def get_invoice_item_quantity
    # item_repository.se.invoice_items.each do |invoice_item|
    #
    # end
    0
  end

end
