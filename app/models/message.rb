class Message < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :offer, touch: true
  has_many :answers, dependent: :destroy
  
  validates_presence_of :content
  validates_presence_of :offer_id
  validates_presence_of :user_id
  validates_presence_of :sender
  validates_presence_of :recipent
  validates :content, length: { maximum: 140 }
end
