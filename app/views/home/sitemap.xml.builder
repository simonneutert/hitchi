xml.instruct! :xml, :version => "1.0"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc 'https://www.hitchi.de/'
    xml.lastmod Time.now.to_date.strftime("%Y-%m-%d")
    xml.changefreq "weekly"
    xml.priority "0.3"
  end

  for id,updated_at in @offers do
    xml.url do
      xml.loc 'https://www.hitchi.de' + offers_mitfahrgelegenheit_path(id)
      xml.lastmod updated_at.strftime("%Y-%m-%d")
      xml.changefreq "daily"
      xml.priority "0.9"
    end
  end
end
