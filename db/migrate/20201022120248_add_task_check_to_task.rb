class AddTaskCheckToTask < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :task_check, :boolean
  end
end
