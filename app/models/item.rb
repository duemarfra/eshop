# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  description :text
#  name        :string
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_items_on_category_id  (category_id)
#  index_items_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (user_id => users.id)
#
class Item < ApplicationRecord
  include PgSearch::Model
  include Favoritable
  include Shoppeable
  pg_search_scope :search_full_text, against: {
                                       name: "A",
                                       description: "B",
                                     }
  ORDER_BY = {
    newest: "created_at DESC",
    expensive: "price DESC",
    cheapest: "price ASC",
  }

  has_one_attached :photo

  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true

  belongs_to :category
  belongs_to :user, default: -> { Current.user }
  has_many :shoppings

  def owner?
    user_id == Current.user&.id
  end
end
