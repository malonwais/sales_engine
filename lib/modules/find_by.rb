module FindBy
  def find_by_last_name(last_name)
    find_by(:last_name, last_name)
  end
  def find_by_first_name(first_name)
    find_by(:first_name, first_name)
  end
  def find_by_id(id)
    id = id.to_i
    find_by(:id, id)
  end
  def find_by_customer_id(customer_id)
    id = id.to_i
    find_by(:customer_id, customer_id)
  end
  def find_by_item_id(item_id)
    id = id.to_i
    find_by(:item_id, item_id)
  end
end