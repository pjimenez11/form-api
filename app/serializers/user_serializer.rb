class UserSerializer < Panko::Serializer
  attributes  :id,
              :first_name,
              :last_name,
              :email,
              :assignments,
              :role

  def assignments
    object.assignments
  end
end
