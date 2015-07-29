require_relative 'file_io'

class Repo

  ATTRIBUTES = {:id =>  lambda {|thing| thing.id},
                :first_name => lambda {|thing| thing.first_name},
                :last_name => lambda {|thing| thing.last_name},
                :name => lambda {|thing| thing.name},
                :description => lambda {|thing| thing.description},
                :unit_price => lambda {|thing| thing.unit_price},
                :merchant_id => lambda {|thing| thing.merchant_id},
                :item_id => lambda {|thing| thing.item_id},
                :invoice_id => lambda {|thing| thing.invoice_id},
                :quantity => lambda {|thing| thing.quantity},
                :credit_card_number => lambda {|thing| thing.credit_card_number},
                :credit_card_expiration_date => lambda {|thing| thing.credit_card_expiration_date},
                :result => lambda {|thing| result.result},
                :customer_id => lambda {|thing| thing.customer_id},
                :status => lambda {|thing| thing.status}
               }

  attr_reader :se, :table

  def initialize(sales_engine)
    @se = sales_engine
    @table = []
  end

  def input_data(file_name)
    FileIO.new(file_name).input_data
  end

  def map_data(child_class, file_name)
    input_data(file_name).each do |object_data|
      @table << child_class.new(object_data)
    end
    @table.shift #removes header info
  end

  def all
    @table
  end

  def random
    @table.sample
  end

  def find_by(symbol, hunt)
    find_all_by(symbol, hunt).first
  end

  def find_all_by(symbol, hunt)
    self.table.select do |thing|
      ATTRIBUTES[symbol].call(thing) == hunt
    end
  end

end
