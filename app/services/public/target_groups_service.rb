module Public
  class TargetGroupsService
    def initialize(params)
      @target_group_params = ActionController::Parameters.new(params)
      @country = Country.find_by_country_code(@target_group_params[:country_code]) if @target_group_params[:country_code]
    end

    def get_target_groups
      target_groups = []
      target_groups = @country.current_target_groups if @country.present?
      target_groups
    end

    def update_target_groups
      # @target_group_params.permit(:country_code, target_groups_attributes: [:id, :name, :_destroy])
    end
  end
end