class AddBusinessToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :business, :boolean, default: false
  end
end
