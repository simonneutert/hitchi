require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    create_users(1,2,3)
    @offer = offers(:one)
    @offer.update(user_id: User.find_by(uid: 1).id)
    @other_offer = offers(:three)
    @other_offer.update(user_id: User.find_by(uid: 1).id)
    @message = messages(:one)
    @message.update(user_id: User.find_by(uid: 2).id)
    @message.answers.new(
      content: "Hello",
      recipent: User.find_by(uid: 2).id,
      sender: User.find_by(uid: 1).id,
      user_id: User.find_by(uid: 1).id).save
    @answer = Answer.first
  end

  test "should get index" do
    login_user
    get :index

    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should not get new if messages were sent" do
    login_user(1)
    current_user = User.find_by(uid: 1)
    get :new, { params: { offer_id: @offer.id } }

    assert_response :redirect
  end

  test "should get new if no messages were sent and user_id differs from offer.user_id" do
    login_user
    Message.destroy_all
    current_user = User.find_by(uid: 2)
    get :new, { params: { offer_id: @offer.id } }

    assert_response :success
  end

  test "should create message" do
    login_user
    current_user = User.find_by(uid: 2)
    assert_difference('Message.count') do
      post :create, { params: { message: { content: @message.content, offer_id: @message.offer_id, user_id: current_user.id } } }
    end

    assert_redirected_to messages_path()
  end

  test 'destroy related message when offer gets destroyed' do
    assert_not_nil @offer
    @old_offer = @offer.id.dup
    @offer.destroy

    assert_empty Message.where(offer_id: @old_offer)
  end

  test 'destroy related answers when offer gets destroyed' do
    assert_not_nil @offer
    @old_offer = @offer.id.dup
    @old_msg = Message.where(offer_id: @old_offer).pluck(:id)
    @offer.destroy

    assert_empty Answer.where(message_id: @old_msg)
  end
end
