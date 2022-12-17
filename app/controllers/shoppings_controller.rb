class ShoppingsController < ApplicationController
  def index
  end

  def create
    item.shopping!
    respond_to do |format|
      format.html {
        redirect_to item_path(item)
      }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("shopping", partial: "items/shopping", locals: { item: item })
      }
    end
  end

  def destroy
    item.unshopping!
    respond_to do |format|
      format.html {
        redirect_to item_path(item), status: :see_other
      }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("shopping", partial: "items/shopping", locals: { item: item })
      }
    end
  end

  def sale
    @sales = saleds
  end

  private

  def item
    @item ||= Item.find(params[:item_id])
  end

  def saleds

    @sales = []
    @shoppings = Shopping.all

    @shoppings.map { |shopping|

      @sale = []

      if shopping.item.user_id == Current.user.id

        if shopping.item.user_id == Current.user.id
          @sale << shopping.item.price
          @sale << shopping.item.name
          @sale << shopping.user.username
        end

        @sales << @sale

      end

    }

    @sales
  end
end
