class ChangeApplicationNumberTypeInForms < ActiveRecord::Migration[7.1]
  def change
    change_column :forms, :application_number, :string
  end
end
