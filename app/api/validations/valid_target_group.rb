class ValidTargetGroup < Grape::Validations::Base
  def validate_param!(attr_name, params)
    country = Country.find_by_country_code(params[:country_code])
    target_group = TargetGroup.find_by_id(params[:target_group_id].to_i)
    target_group = target_group.root if target_group
    unless country.present? && target_group.present? && country.target_groups.pluck("id").include?(target_group.id)
      raise Grape::Exceptions::Validation, params: [@scope.full_name(attr_name)], message: "is not part of the requested country"
    end
  end
end
