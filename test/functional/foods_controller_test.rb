require 'test_helper'

class FoodsControllerTest < ActionController::TestCase
  setup do
    @food = foods(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:foods)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create food" do
    assert_difference('Food.count') do
      post :create, food: { days: @food.days, daytime: @food.daytime, entree: @food.entree, place_id: @food.place_id, sides: @food.sides }
    end

    assert_redirected_to place_food_path(assigns(:food))
  end

  test "should show food" do
    get :show, id: @food
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @food
    assert_response :success
  end

  test "should update food" do
    put :update, id: @food, food: { days: @food.days, daytime: @food.daytime, entree: @food.entree, place_id: @food.place_id, sides: @food.sides }
    assert_redirected_to place_food_path(assigns(:food))
  end

  test "should destroy food" do
    assert_difference('Food.count', -1) do
      delete :destroy, id: @food
    end

    assert_redirected_to foods_path
  end
end
