class ChangeTitleToProyectNameToForms < ActiveRecord::Migration[7.1]
  def change
    rename_column :forms, :title, :proyect_name
  end
end
