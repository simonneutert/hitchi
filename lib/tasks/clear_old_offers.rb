desc "clear offers that are old"
task :clear_old_offers => :environment do
  Offer.where("departuredate < ?", Date.today).find_each { |offer| offer.destroy }
end
