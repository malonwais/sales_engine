class Transaction
  attr_reader :id, :invoice_id, :credit_card_number,
              :credit_card_expiration_date,
              :result, :created_at, :updated_at,
              :transaction_repository

  def initialize(input_data, transaction_repository)
    @id = input_data[0]
    @invoice_id = input_data[1]
    @credit_card_number = input_data[2]
    @credit_card_expiration_date = input_data[3]
    @result = input_data[4]
    @created_at = input_data[5]
    @updated_at = input_data[5]
    @transaction_repository = transaction_repository
  end

  def invoice
    transaction_repository.se.invoice_repo.find_by(:id, invoice_id)
    # repo_table(:invoice_repo).find do |invoice|
    #   find_by(:id, transaction_id).invoice_id == invoice.id
    # end
  end

end
