require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    create_users
    @user = User.first
  end

  test 'user has a uid' do
    @user.uid = nil
    assert_not @user.valid?
  end
end
