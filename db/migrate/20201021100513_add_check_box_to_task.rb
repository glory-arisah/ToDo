class AddCheckBoxToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :checkbox, :boolean
  end
end
