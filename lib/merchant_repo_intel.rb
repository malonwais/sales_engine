class MerchantRepoIntel < Repo


  def group_invoices_with_merchant
    repo_table(:invoice_repo).group_by do |invoice|
      invoice.merchant_id
    end
  end

  def group_invoice_items_with_invoice
    repo_table(:invoice_item_repo).group_by do |invoice_item|
      invoice_item.invoice_id
    end
  end

  def total_inv_item_price(i_item)
    i_item.unitprice * i_item.quantity
  end

  def total_invoice_prices(inv_to_inv_items)
    invoice_prices = Hash[inv_to_inv_items.map do |inv, inv_item|
      [inv, total_inv_item_price(inv_item) ]


  end

end
