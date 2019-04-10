require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  def setup
    @offer = offers(:one)
  end

  test 'invalid offer without user_relation' do
    @offer.user_id = nil
    assert_not @offer.valid?
  end

  test 'invalid offer without departure' do
    @offer.departurelocal = nil
    assert_not @offer.valid?
  end

  test 'invalid offer without destination' do
    @offer.destinationlocal = nil
    assert_not @offer.valid?
  end

  test 'invalid offer without departuretime' do
    @offer.departuretime = nil
    assert_not @offer.valid?
  end

  test 'invalid offer without departuredate' do
    @offer.departuredate = Time.now - 1.days
    assert_not @offer.valid?
  end

  test 'invalid when in the past' do
    @offer.departuredate = Time.now - 1.days
    assert_not @offer.valid?
  end

  test 'invalid if rules not accepted' do
    @offer.rules = false
    assert_not @offer.valid?
  end

  test 'description in appropriate length' do
    # validates :description, length: { maximum: 750 }
    @offer.description = "test " * (750 / "test ".size + 1)
    assert_not @offer.valid?
  end

  test 'between_stops in appropriate length' do
    @offer.between_stops = "test " * (140 / "test ".size + 1)
    assert_not @offer.valid?
  end

  test 'departuretime in appropriate length' do
    @offer.departuretime = "test " * (40 / "test ".size + 1)
    assert_not @offer.valid?
  end

  test 'departurelocal in appropriate length' do
    @offer.departurelocal = "test " * (40 / "test ".size + 1)
    assert_not @offer.valid?
  end

  test 'destinationlocal in appropriate length' do
    @offer.destinationlocal = "test " * (40 / "test ".size + 1)
    assert_not @offer.valid?
  end

  test 'departuredate is not too far in the future' do
    @offer.departuredate = Date.today + 6.months + 1.days
    assert_not @offer.valid?
  end

  test 'departure und destination must differ' do
    @offer.destinationlocal = "Mainz"
    @offer.departurelocal = "Mainz"
    assert_not @offer.valid?
  end

end
