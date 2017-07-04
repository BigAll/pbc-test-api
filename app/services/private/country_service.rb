module Private
  class CountryService
    def initialize(params)
      @params = ActionController::Parameters.new(params)
      @country = Country.find_by_country_code(@params[:country_code]) if @params[:country_code]
    end

    def calculate_price
      @country.panel_provider.price if @country && @country.panel_provider
    end
  end
end