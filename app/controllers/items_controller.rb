class ItemsController < ApplicationController
  skip_before_action :protect_pages, only: [:index, :show]

  def index
    @categories = Category.order(name: :asc).load_async
    @pagy, @items = pagy_countless(FindItems.new.call(items_params_index).load_async, items: 12)
  end

  def show
    item
  end

  def new
    authorize!
    @item = Item.new
  end

  def create
    authorize!
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path, notice: t(".created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize! item
  end

  def update
    authorize! item
    if item.update(item_params)
      redirect_to items_path, notice: t(".updated")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! item
    item.destroy
    redirect_to items_path, notice: t(".destroyed"), status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :photo, :category_id)
  end

  def items_params_index
    params.permit(:category_id, :min_price, :max_price, :query_text, :order_by, :page, :favorites, :user_id, :shoppings)
  end

  def item
    @item ||= Item.find(params[:id])
  end
end
