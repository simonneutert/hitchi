require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    create_users
    @user = User.first
  end

  test 'user has a id' do
    @user.id = nil
    assert_not @user.valid?
  end
end
