require_relative 'file_io'

class Repo
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
    self.table.find do |thing|
      thing.send(symbol) == hunt
    end
  end

  def find_all_by(symbol, hunt)
    self.table.select do |thing|
      thing.send(symbol) == hunt
    end
  end

end
