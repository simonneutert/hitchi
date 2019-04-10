# production server runs this every 24h at least once
desc "clear gmap lat long data according to google's tos"
task :clear_gmap_lat_long_cache => :environment do

  def clearer(model)
    model.all.each do |m|
      m.latitude = ""
      m.longitude = ""
      m.save(validate: false)
      m.save!
      sleep 66
    end
  end

  def destroyer(model, relation, col)
    model.where.not(id: relation.all.pluck(col)).destroy_all
  end

  # scheduler set to hourly rake task execution
  # but skips if time doesn't match ;-)
  return unless [0, 18].include? Time.now.zone.hour
  destroyer(Departure, Offer, :departure_id)
  destroyer(Destination, Offer, :destination_id)
  [Destination, Departure].map { |e| clearer(e) }
end
