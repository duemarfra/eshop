class AddCustomerToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :customer, :boolean, default: true
  end
end
