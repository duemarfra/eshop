class AddNotNullToCategoryName < ActiveRecord::Migration[7.0]
  def change
    change_column_null :categories, :name, false
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
