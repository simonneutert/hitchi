class Answer < ApplicationRecord
  belongs_to :message, touch: true
  belongs_to :user, touch: true
  validates_presence_of :content
  validates_presence_of :recipent
  validates_presence_of :sender
  validates :content, length: { maximum: 140 }
end
