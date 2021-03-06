require_relative 'repository'
require_relative 'transaction'

class TransactionRepository < Repository

  def load_data(csv_path)
    map_data(Transaction, File.join(csv_path, "transactions.csv"))
  end

  def add_transaction(invoice_id, info)
    new_id = table.last.id + 1
    cc_number = info[:credit_card_number]
    cc_exp = info[:credit_card_expiration]
    result = info[:result]
    created_at = Time.now.utc.to_s
    updated_at = created_at

    new_record = [new_id, invoice_id, cc_number, cc_exp,
                  result, created_at, updated_at]
    new_transaction = Transaction.new(new_record, self)
    table.push(new_transaction)
    @quick_lookup_table = populate_quick_lookup_table(table)
    new_transaction
  end

end
