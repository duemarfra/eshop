require "test_helper"

class ShoppingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @megadrive = items(:megadrive)
    @switch = items(:switch)
  end

  test "should return my shopping cart" do
    get favorites_url
    assert_response :success
  end

  test "should create shopping item to cart" do
    assert_difference("Shopping.count", 1) do
      post shoppings_url(item_id: @megadrive.id)
    end

    assert_redirected_to item_path(@megadrive)
  end

  test "should unshopping item to cart" do
    assert_difference("Shopping.count", -1) do
      dalete shopping_url(@switch.id)
    end

    assert_redirected_to item_path(@switch)
  end
end
