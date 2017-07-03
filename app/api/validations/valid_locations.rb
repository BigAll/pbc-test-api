class ValidLocations < Grape::Validations::Base
  def validate_param!(attr_name, params)
    country = Country.find_by_country_code(params[:country_code])
    country_locations_ids = country.locations.pluck("id") if country
    param_locations_ids = params[:locations].map{|el| el[:id]}

    unless country.present? && param_locations_ids & country_locations_ids == param_locations_ids
      raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "provided locations are not part of the country"
    end
  end
end
