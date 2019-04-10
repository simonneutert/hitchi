class ApplicationController < ActionController::Base
  require 'will_paginate/array'

  protect_from_forgery with: :exception
  # loading the following functions as global helper_methods
  helper_method :current_user
  helper_method :message_counter
  helper_method :hitchilogourl

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def hitchilogourl
    @hitchilogourl = "https://www.hitchi.de/hitchi_logo.png"
  end

  def message_counter
    if current_user
      # database query with ands and ors -> OR splits both the AND query parts
      q1 = "recipent = #{current_user.id} OR sender = #{current_user.id}"
      q2 = "recipent = #{current_user.id} AND recipentclick = FALSE OR sender = #{current_user.id} AND senderclick = FALSE"
      @messagecount =  Message.where(q1).where(q2).pluck(:id).count
      return @messagecount
    else
      return
    end #if current_user?
  end

end
