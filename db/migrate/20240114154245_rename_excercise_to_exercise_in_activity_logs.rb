class RenameExcerciseToExerciseInActivityLogs < ActiveRecord::Migration[7.0]
  def change
    rename_column :activity_logs, :excercise, :exercise
  end
end
