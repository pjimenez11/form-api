class AssignmentSerializer < Panko::Serializer
  attributes :id,
             :user_assignment,
             :form,
             :application_number,
             :date_created,
             :requesting

  def user_assignment
    [object.user.first_name, object.user.last_name].join(' ')
  end

  def form
    object.form.proyect_name
  end

  def application_number
    object.form.application_number
  end

  def date_created
    object.form.date
  end

  def requesting
    [object.form.creator.first_name, object.form.creator.last_name].join(' ')
  end

end
