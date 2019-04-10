require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get show / landing page" do
    get :show
    assert_response :success
  end

  test "should get sitemap" do
    get :sitemap, format: "xml"
    assert_response :success
  end

  test "should get explain" do
    get :explain
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

  test "should get agb_datenschutz" do
    get :agbdatenschutz
    assert_response :success
  end

  test "should get impressum" do
    get :impressum
    assert_response :success
  end

end
