require 'test_helper'

class FeePlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get fee_plans_index_url
    assert_response :success
  end

  test "should get new" do
    get fee_plans_new_url
    assert_response :success
  end

  test "should get create" do
    get fee_plans_create_url
    assert_response :success
  end

  test "should get edit" do
    get fee_plans_edit_url
    assert_response :success
  end

  test "should get update" do
    get fee_plans_update_url
    assert_response :success
  end

  test "should get destroy" do
    get fee_plans_destroy_url
    assert_response :success
  end

end
