module Shoppeable
  extend ActiveSupport::Concern
  included do
    has_many :shoppings, dependent: :destroy

    def shopping!
      shoppings.create(user: Current.user)
    end

    def unshopping!
      shopping.destroy
    end

    def shopping
      shoppings.find_by(user: Current.user)
    end
  end
end
