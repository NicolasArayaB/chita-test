module PricingHelper
  def set_result(json_response)
    financing_cost = (@document_amount.to_i * json_response['advance_percent'] / 100) * ((json_response['document_rate'] / 100) / 30 * ((@expiration_date.to_date - Date.today).to_i + 1))
    receiving_amount = (@document_amount.to_i * json_response['advance_percent'] / 100) - (financing_cost + json_response['commission'] / 100)
    surplus = @document_amount.to_i - (@document_amount.to_i * json_response['advance_percent'] / 100)
    { financing_cost: financing_cost, receiving_amount: receiving_amount, surplus: surplus }
  end
end
