class Advertimage < ApplicationRecord
  belongs_to :advert, touch: true
  mount_uploader :image, AdvertimageUploader
  validates :image, file_size: { less_than: 200.kilobytes }
end
