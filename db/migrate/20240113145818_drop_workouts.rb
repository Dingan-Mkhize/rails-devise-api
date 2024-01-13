class DropWorkouts < ActiveRecord::Migration[6.0]
  def up
    drop_table :workouts
  end

  def down
    create_table :workouts do |t|
      t.date :date
      t.integer :duration
      # add back any other columns that workouts had
      t.timestamps
    end
  end
end
