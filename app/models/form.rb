class Form < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :assignments
  has_many :assigned_users, through: :assignments, source: :user

  enum status: {
    created: 0,
    assigned: 1,
    approved: 2,
    canceled: 3,
  }

  enum priority_level: {
    low: 0,
    medium: 1,
    high: 2,
    critical: 3
  }
end
