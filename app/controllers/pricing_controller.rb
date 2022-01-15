class PricingController < ApplicationController
  require 'rest-client'
  include PricingHelper
  
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
    
    response = Chita::Get_price.calling(url)
    json_response = JSON.parse response
    if json_response['status'] =='bad_request'
      redirect_to root_path
      flash.alert = 'Por favor verifique los datos ingresados'
    else
      @pricing = set_result(json_response)
    end
  end
end
