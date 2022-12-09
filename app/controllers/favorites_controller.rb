class FavoritesController < ApplicationController
  def index
  end

  def create
    item.favorite!
    respond_to do |format|
      format.html {
        redirect_to item_path(item)
      }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("favorite", partial: "items/favorite", locals: { item: item })
      }
    end
  end

  def destroy
    item.unfavorite!
    respond_to do |format|
      format.html {
        redirect_to item_path(item), status: :see_other
      }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace("favorite", partial: "items/favorite", locals: { item: item })
      }
    end
  end

  private

  def item
    @item ||= Item.find(params[:item_id])
  end
end
