class CreateActivityLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :activity_logs do |t|
      t.string :excercise
      t.integer :duration
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
