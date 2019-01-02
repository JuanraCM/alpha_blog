require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "Example", email: "example@outlook.com", password: "1234", admin: true)
  end

  test "should get index" do
    get categories_path
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user, "1234")
    get new_category_path
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)
    assert_response :success
  end

  test "should redirect create when admin is not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: {category: {name: "sports"}}
    end
    assert_redirected_to categories_path
  end
end