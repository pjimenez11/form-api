class FormSerializer < Panko::Serializer
  attributes :id,
             :title,
             :description,
             :application_number,
             :date,
             :address,
             :justification,
             :status,
             :priority_level,
             :deadline,
             :requesting,
             :assigned_users

  def requesting
    [object.creator.first_name, object.creator.last_name].join(' ')
  end

  def assigned_users
    users = object.assigned_users
    users.map(&:first_name)
  end
end
