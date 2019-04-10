require 'test_helper'

class AnswerTest < ActiveSupport::TestCase

  def setup
    @answer = Answer.new()
    @answer.user_id = 1
    @answer.message_id = 1
    @answer.content = "Hello Tester"
    @answer.sender = 1
    @answer.recipent = 2
  end

  test 'answer belongs to a user' do
    @answer.user_id = nil
    assert_not = @answer.valid?
  end

  test 'answer belongs to a message' do
    @answer.message_id = nil
    assert_not = @answer.valid?
  end

  test 'answer has a message' do
    @answer.content = nil
    assert_not = @answer.valid?
  end

  test 'answer message length shorter than 140 characters' do
    @answer.content = ("test " * 28) << "a"
    assert_not = @answer.valid?
  end

  test 'answer has sender and recipent' do
    @answer.sender = nil
    @answer.recipent = nil
    assert_not @answer.valid?
  end

end
