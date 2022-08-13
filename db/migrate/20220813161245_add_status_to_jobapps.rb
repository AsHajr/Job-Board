class AddStatusToJobapps < ActiveRecord::Migration[7.0]
  def change
    add_column :jobapps, :status, :boolean, default: false
  end
end
