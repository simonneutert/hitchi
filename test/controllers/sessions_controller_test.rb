require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get create" do
    create_user
    get :create
    assert_response :redirect
  end

  test "should get destroy" do
    get :destroy
    assert_nil(session[:user_id])
    assert_response :redirect
  end

end
