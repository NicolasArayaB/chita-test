class PricingController < ApplicationController
  require 'rest-client'
  
  def index
  end

  def get_price
    @client_dni = params[:client_dni]
    @debtor_dni = params[:debtor_dni]
    @document_amount = params[:document_amount]
    @folio = params[:folio]
    @expiration_date = params[:expiration_date]

    url = 'https://chita.cl/api/v1/pricing/simple_quote?client_dni=' + @client_dni +
          '&debtor_dni=' + @debtor_dni + '&document_amount=' + @document_amount +
          '&folio=' + @folio + '&expiration_date=' + @expiration_date
    
    response = RestClient.get url, { 'X-Api-Key': 'UVG5jbLZxqVtsXX4nCJYKwtt' }
    json_response = JSON.parse response

    @financing_cost = (@document_amount.to_i * json_response['advance_percent'] / 100) * ((json_response['document_rate'] / 100) / 30 * ((@expiration_date.to_date - Date.today).to_i + 1))
    @receiving_amount = (@document_amount.to_i * json_response['advance_percent'] / 100) - (@financing_cost + json_response['commission'] / 100)
    @surplus = @document_amount.to_i - (@document_amount.to_i * json_response['advance_percent'] / 100)
  end
end
