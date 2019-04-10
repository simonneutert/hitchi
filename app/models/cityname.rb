class Cityname < ApplicationRecord
  validates_uniqueness_of :name
end
