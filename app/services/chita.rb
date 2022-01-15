module Chita
  class Get_price
    def self.calling(url)
      RestClient.get url, { 'X-Api-Key': Rails.application.credentials.dig(:chita, :api_key) }
    end
  end
end