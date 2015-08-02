require_relative './sales_engine'

puts "hello world"
engine = SalesEngine.new
engine.startup

engine.invoice_item_repo.table.each do |invoice_item|
  #find out who your merchant is
    invoice_item.invoice_id

end
binding.pry
