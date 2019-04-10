require 'test_helper'

class OffersControllerTest < ActionController::TestCase

  setup do
    @offer = offers(:one)
    create_users(1,2,3)
  end

  test "get account page when logged in" do
    login_user
    get :overview
    assert_response :success
  end

  test "not get account page when logged in" do
    get :overview
    assert_redirected_to destroy_user_session_path, method: :delete
  end

  test "should redirect on index" do
    get :index
    assert_response :redirect
  end

  test "should get new when logged in" do
    login_user
    get :new
    assert_response :success
  end

  test "should not get new when not logged in" do
    get :new
    assert_response :redirect
  end

  test 'should create offer' do
    login_user
    assert_difference('Offer.count') do
      post :create,
        params: {
                offer: {
                          user_id: User.first.id,
                          active: @offer.active,
                          departuredate: @offer.departuredate,
                          departurelocal: @offer.departurelocal,
                          departuretime: @offer.departuretime,
                          description: @offer.description,
                          destinationlocal: @offer.destinationlocal,
                          rules: true,
                          seek: @offer.seek } }
    end

    assert_redirected_to offers_mitfahrgelegenheit_path(assigns(:offer))
  end


  test "should show offer" do
    get :show, params: {id: Offer.first.id}
    assert_response :success
  end

  test "should redirect edit when logged in but not owner" do
    login_user
    get :edit, params: { id: 9999991212121 }
    assert_response :redirect
  end

  test "should redirect edit when logged and owner" do
    login_user
    @this_offer = Offer.where(user_id: session[:user_id]).first
    assert_not_nil @this_offer
    get :edit, params: { id: @this_offer }
    assert_response :success
  end

  test "should update offer when logged in" do
    login_user
    @this_offer = Offer.where(user_id: session[:user_id]).first
    assert_not_nil @this_offer
    patch :update, params: { id: @this_offer.id, offer: { seek: false,
                                                          destinationlocal: "Mainz",
                                                          departurelocal: "Heilbronn"} }
    assert_redirected_to(
      offers_mitfahrgelegenheit_path(assigns(:offer), facebook_refresh: true))
  end

  test "should destroy offer when logged in" do
    login_user
    @this_offer = Offer.where(user_id: session[:user_id]).first
    assert_not_nil @this_offer
    assert_difference('Offer.count', -1) do
      delete :destroy, params: { id: @this_offer }
    end
    assert_redirected_to offers_overview_path()
  end

  test "should not destroy offer when logged in" do
    not_logged_in
    @this_offer = Offer.where(user_id: User.first.id).first
    assert_not_nil @this_offer
    assert_no_difference('Offer.count') do
      delete :destroy, params: { id: @this_offer }
    end
    assert_response :redirect
  end

  test "find offer" do
    @offer = Offer.where(departuredate: Date.today + 1.days)
    assert_not_empty @offer
  end

  test "match offers" do
    login_user
    offers(:one).user_id = User.first.id
    offers(:one).save
    offers(:three).user_id = User.last.id
    offers(:three).save
    @offermatches = Offer.where(destination_id: @offer.destination_id, departure_id: @offer.departure_id, departuredate: @offer.departuredate, seek: true, active: true).where.not(user_id: session[:user_id])
    assert_not_empty(@offermatches)
  end
end
