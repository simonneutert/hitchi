ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def create_user
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  def create_users(*uids)
    uids.each do |uid|
      create_user
      request.env["omniauth.auth"].uid = uid
      user = User.from_omniauth(request.env["omniauth.auth"])
      user.emailmsgnotification = nil
      user.touch
      user.save
    end
  end

  def login_user(uid=nil)
    create_users(1,2,3) unless User.find_by(uid: 1)
    if uid.nil?
      id = User.first.id
    else
      id = User.find_by(uid: uid).id
    end
    request.env["devise.mapping"] = Devise.mappings[:user] # If using Devise
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    # Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
    # Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    session[:user_id] = User.find(id).id
    session[:expires_at] = Time.now + 30.minutes
  end

  def not_logged_in
    current_user = nil
    session["user_id"] = nil
    session[:expires_at] = Time.now - 30.minutes
  end
end
