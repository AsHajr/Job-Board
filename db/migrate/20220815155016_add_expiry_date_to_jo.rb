class AddExpiryDateToJo < ActiveRecord::Migration[7.0]
  def change
    add_column :jobs, :expiry_date, :string
  end
end
