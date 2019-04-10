require 'test_helper'

class AnswersControllerTest < ActionController::TestCase
  setup do
    @answer = answers(:one)
    create_users
    login_user(3)
    current_user = User.find(session["user_id"])
    @answer.message.update_attribute('sender', current_user.id)
  end

  test 'kick out when not signed in' do
    not_logged_in

    get :index, {params: {message_id: @answer.message}}
    assert_response :redirect

    get :edit, {params: {id: @answer, message_id: @answer.message}}
    assert_response :redirect

    patch :update, {params: {id: @answer, message_id: @answer.message}}
    assert_response :redirect

    delete :destroy, {params: {id: @answer, message_id: @answer.message}}
    assert_redirected_to root_path
  end

  test 'edit is not allowed' do
    get :edit, {params: {id: @answer, message_id: @answer.message}}

    assert_response :redirect
  end

  test 'update is not allowed' do
    patch :update, {params: {id: @answer, message_id: @answer.message}}

    assert_response :redirect
  end

  test 'new message' do
    get :new, {params: {message_id: @answer.message.id}}

    assert_response :success
  end
end
