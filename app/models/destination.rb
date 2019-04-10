class Destination < ActiveRecord::Base
  has_many :offers
  
  geocoded_by :name # can also be an IP address
  after_validation :geocode unless Rails.env.test?
end
