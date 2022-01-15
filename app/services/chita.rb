module Chita
  class Get_price
    def self.calling(url)
      begin
        RestClient.get url, { 'X-Api-Key': Rails.application.credentials.dig(:chita, :api_key) }
      rescue => err
        err.response
      end
    end
  end
end