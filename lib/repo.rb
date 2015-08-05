require_relative 'file_io'
require_relative 'modules/find_by'
require_relative 'modules/find_all_by'
require 'bigdecimal'


class Repo
  # attr_reader :table
  include FindBy
  include FindAllBy
  
  def input_data(file_name)
    FileIO.new(file_name).input_data
  end
  
  def map_data(child_class, file_name)
    input_data(file_name).each do |object_data|
      @table << child_class.new(object_data, self)
    end
    @table.shift #removes header info
  end
  
  def populate_hash(table)
    output = Hash.new()
    table[0].args.each do |arg|
      output[arg] = {}
    end
    
    table.reverse!
    table.each do |record|
      record.args.each do |arg|
        output[arg][record.send(arg)] =  record
      end
    end
    output
  end
  
  def all
    @table
  end
  
  def random
    @table.sample
  end
  
  def find_by(symbol, hunt)
    hash[symbol][hunt]
    # self.table.find do |thing|
    #   thing.send(symbol) == hunt
    # end
  end
  
  def find_all_by(symbol, hunt)
    self.table.select do |thing|
      thing.send(symbol) == hunt
    end
  end
  
  def find_all_by_date(symbol, date)
    if date.class == Date
      date = date.strftime("%Y-%m-%d")
    else
      date = Date.parse(date).strftime("%Y-%m-%d")
    end
    self.table.select do |thing|
      thing.send(symbol)[0..9] == date
    end
  end
  
  def repo_table(symbol_thing)
    @se.send(symbol_thing).table
  end
  def inspect
    self.Class
  end
  
end
