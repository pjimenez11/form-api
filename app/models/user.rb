class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :database_authenticatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { admin: 1, developer: 2, tester: 3 }

  belongs_to :company
  accepts_nested_attributes_for :company
  has_many :assignments
  has_many :assigned_forms, through: :assignments, source: :form
  has_many :forms, through: :assignments

  def jwt_payload
    super
  end
end

