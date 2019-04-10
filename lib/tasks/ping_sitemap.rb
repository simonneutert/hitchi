desc 'ping sitemap'
task ping_sitemap: :environment do
  require 'net/http'
  uri = URI('https://www.google.com/webmasters/tools/ping?sitemap=https%3A%2F%2Fwww.hitchi.de%2Fsitemap.xml')
  Net::HTTP.get(uri)
end
