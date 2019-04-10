class Advert < ApplicationRecord
  has_one :advertimage, dependent: :destroy
  belongs_to :admin
  accepts_nested_attributes_for :advertimage, :allow_destroy => true
end
