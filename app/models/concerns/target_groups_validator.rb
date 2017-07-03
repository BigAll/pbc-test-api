class TargetGroupsValidator < ActiveModel::Validator
  def validate(record)
    if(record.target_groups.present?)
      record.target_groups.each do |target_group|
        record.errors.add(:target_groups, "Target Group #{target_group.name} is not root") if !target_group.root?
      end
    end
  end
end
