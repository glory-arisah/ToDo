class ChangeDefaultTaskCheck < ActiveRecord::Migration[6.0]
  def change
    change_column_default :tasks, :task_check, false
  end
end
