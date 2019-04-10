# production server runs this every 24h at least once
desc "clear gmap lat long data according to google's tos"
task :clear_gmap_lat_long_cache_now => :environment do

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
    model.where.not(id: relation.all.pluck(col)).each do |entry|
      begin
        entry.destroy!
      rescue
        next
      end
    end
  end

  destroyer(Departure, Offer, :departure_id)
  destroyer(Destination, Offer, :destination_id)
  destroyer(Departure, FbOffer, :departure_id)
  destroyer(Destination, FbOffer, :destination_id)

  [Destination, Departure].map { |e| clearer(e) }

end
