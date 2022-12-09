# == Schema Information
#
# Table name: shoppings
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_shoppings_on_item_id              (item_id)
#  index_shoppings_on_user_id              (user_id)
#  index_shoppings_on_user_id_and_item_id  (user_id,item_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (item_id => items.id)
#  fk_rails_...  (user_id => users.id)
#
class Shopping < ApplicationRecord
  validates :user, uniqueness: { scope: :item }
  belongs_to :user
  belongs_to :item
end
