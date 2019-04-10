class User < ApplicationRecord
  has_many :offers
  has_many :messages
  validates_presence_of :uid
  #attr_accessor :id

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid      = auth.uid
      user.name     = auth.info.name
      if auth.info.email
        user.email  = auth.info.email
      end
      user.save
    end
  end

end
