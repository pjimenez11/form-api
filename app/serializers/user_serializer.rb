class UserSerializer < Panko::Serializer
  attributes :id,
             :email,
             :assignments,
             :role

  def assignments
    object.assignments
  end
end
