class DeleteDescriptionOnAssignments < ActiveRecord::Migration[7.1]
  def change
    remove_column :assignments, :description
  end
end
