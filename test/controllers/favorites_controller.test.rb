require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
    @megadrive = items(:megadrive)
    @switch = items(:switch)
  end

  test "should return my favorites" do
    get favorites_url
    assert_response :success
  end

  test "should create favorite" do
    assert_difference("Favorite.count", 1) do
      post favorites_url(item_id: @megadrive.id)
    end

    assert_redirected_to item_path(@megadrive)
  end

  test "should unfavorite" do
    assert_difference("Favorite.count", -1) do
      dalete favorite_url(@switch.id)
    end

    assert_redirected_to item_path(@switch)
  end
end
