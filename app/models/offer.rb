class Offer < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :departure, touch: true
  belongs_to :destination, touch: true
  has_many :messages, dependent: :destroy

  validates_presence_of :departurelocal, :departuredate, :departuretime, :destinationlocal
  validates_presence_of :user_id
  validates_presence_of :rules
  validates :description, length: { maximum: 750 }
  validates :departuretime, length: { maximum: 40 }
  validates :departurelocal, length: { maximum: 40 }
  validates :destinationlocal, length: { maximum: 40 }
  validates :between_stops, length: { maximum: 140 }
  validate :departuredate_cannot_be_in_the_past
  validate :departuredate_cannot_be_too_far_in_the_future
  validate :traveling

  attr_accessor :diameterdep, :diameterdest, :truebetweenstop
  attr_accessor :near_departures
  attr_accessor :near_destinations

  def traveling
    if departurelocal == destinationlocal && departurelocal != "" && destinationlocal != ""
      errors.add(:destination, "und Abfahrtsort müssen sich unterscheiden")
    end
  end

  def departuredate_cannot_be_in_the_past
    if departuredate < Date.today
      errors.add(:departuredate, "dann wärst du schon unterwegs")
    end
  end

  def departuredate_cannot_be_too_far_in_the_future
    if departuredate > Date.today + 6.months
      errors.add(:departuredate, "darf maximal sechs Monate in der Zukunft liegen")
    end
  end
  #accepts_nested_attributes_for :user

  def self.find_active(searchdate, show_seeks=false)
    begin
      where(
      departuredate: [
        (searchdate.to_date - 1.days),
        (searchdate.to_date + 1.days),
        (searchdate.to_date + 2.days),
        searchdate
        ],
        seek: show_seeks,
        active: true
        )
    rescue NoMethodError
      where(active: true, seek: show_seeks)
    end

  end

  def self.fahrtsuche(query)
    where("departurelocal ilike ?", "%#{query}%")
  end
  def self.zielsuche(query)
    where("destinationlocal ilike ?", "%#{query}%")
  end
  def self.stopsuche(query)
    where("between_stops ilike ?", "%#{query}%")
  end
  # def self.datumsuche(query)
  #   where("departuredate like ?", "%#{query}%")
  # end

  def find_near
    # get near departures
    self.near_departures = []
    dep = Departure.find departure_id
    Departure.near(dep.name, 15).each do |nd|
      self.near_departures << nd.id
      # puts near_departures.inspect
      # puts "_"*30
    end
    # get near destinations
    self.near_destinations = []
    dest = Destination.find destination_id
    Destination.near(dest.name, 15).each do |nd|
      self.near_destinations << nd.id
      # puts near_destinations.inspect
      # puts "_"*30
    end
  end

end
