module Public
  class LocationsService
    def initialize(params)
      @location_params = ActionController::Parameters.new(params)
      @country = Country.find_by_country_code(@location_params[:country_code]) if @location_params[:country_code]
    end

    def get_locations
      locations = []
      locations = @country.current_locations if @country
      locations
    end

    def update_locations
      # @location_params.permit(:country_code, locations_attributes: [:id, :panl_size, :_destroy])
    end
  end
end