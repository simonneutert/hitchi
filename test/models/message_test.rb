require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    @m = Message.new()
    @m.user_id = User.first.id
    @m.content = "Hallo"
    @m.offer_id = Offer.first.id
  end

  test 'message cannot be empty' do
    @m.content = nil
    assert_not @m.valid?
  end

  test 'message cannot be longer than 140 characters' do
    @m.content = ("abc a" * 28) << "a"
    assert_not @m.valid?
  end

  test 'message belongs to user' do
    @m.user_id = nil
    assert_not @m.valid?
  end

  test 'message belongs to offer' do
    @m.offer_id = nil
    assert_not @m.valid?
  end

  test 'message has sender and recipent' do
    @m.sender = nil
    @m.recipent = nil
    assert_not @m.valid?
  end

end
