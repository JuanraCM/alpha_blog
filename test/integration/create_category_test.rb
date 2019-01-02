require 'test_helper'

class CreateCategoryTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "Example", email: "example@outlook.com", password: "1234", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "1234")
    get new_category_path
    assert_template 'categories/new'

    assert_difference 'Category.count', 1 do
        post categories_path, params: { category: { name: "sports" } }
        follow_redirect!
    end

    assert_template 'categories/index'
    assert_match "sports", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@user, "1234")
    get new_category_path
    assert_template 'categories/new'

    assert_no_difference 'Category.count' do
        post categories_path, params: { category: { name: "" } }
    end

    assert_template 'categories/new'
    assert_select 'div#errors-panel'
    assert_select 'div.panel-body'
  end
end