require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login
  end

  test "render a list of items" do
    get items_path
    assert_response :success
    assert_select ".item", 12
    assert_select ".category", 10
  end

  test "render a list of items filtered by category" do
    get items_path(category_id: categories(:consoles).id)
    assert_response :success
    assert_select ".item", 1
  end

  test "render a list of items filtered by min_price and max_price" do
    get items_path(min_price: 90, max_price: 150)
    assert_response :success
    assert_select ".item", 9
    assert_select "h3", "Samsung s22"
  end

  test "search a item by query text (name or description)" do
    get items_path(query_text: "s22")
    assert_response :success
    assert_select ".item", 1
    assert_select "h3", "Samsung s22"
  end

  test "sort products by expensive prices first" do
    get items_path(order_by: "expensive")
    assert_response :success
    assert_select ".item", 12
    assert_select ".items .item:first-child h3", "Seat Panda clásico"
  end

  test "sort products by cheapest prices first" do
    get items_path(order_by: "cheapest")
    assert_response :success
    assert_select ".item", 12
    assert_select ".items .item:first-child h3", "El hobbit"
  end

  test "render a detailed item page" do
    get item_path(items(:psp))
    assert_response :success
    assert_select ".name", "Play Station Portatil"
    assert_select ".description", "The best compact console"
    assert_select ".price", "$80"
  end

  test "render a new product form" do
    get new_item_path
    assert_response :success
    assert_select "form"
  end

  test "allow to create a new item" do
    post items_path, params: {
                       item: {
                         name: "moto g1",
                         description: "best moto",
                         price: 55,
                         category_id: categories(:smartphones).id,
                       },
                     }

    assert_redirected_to items_path
    assert_equal flash[:notice], "Your item was saved successfully"
  end

  test "Does not allow to create a new item with empty fields" do
    post items_path, params: {
                       item: {
                         name: "moto g1",
                         price: 55,
                       },
                     }

    assert_response :unprocessable_entity
  end

  test "render an edit product form" do
    get edit_item_path(items(:s22))
    assert_response :success
    assert_select "form"
  end

  test "allow to update a item" do
    patch item_path(items(:psp)), params: {
                                    item: {
                                      price: 66,
                                    },
                                  }

    assert_redirected_to items_path
    assert_equal flash[:notice], "Your item was updated successfully"
  end

  test "Does not allow to update a item with an invalid field" do
    patch item_path(items(:psp)), params: {
                                    item: {
                                      price: nil,
                                    },
                                  }

    assert_response :unprocessable_entity
  end

  test "can delete items" do
    assert_difference("Item.count", -1) do
      delete item_path(items(:psp))
    end
    assert_redirected_to items_path
    assert_equal flash[:notice], "Your item was deleted successfully"
  end
end
