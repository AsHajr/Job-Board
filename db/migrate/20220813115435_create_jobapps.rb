class CreateJobapps < ActiveRecord::Migration[7.0]
  def change
    create_table :jobapps do |t|
      t.string :created_by
      t.boolean :status
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
