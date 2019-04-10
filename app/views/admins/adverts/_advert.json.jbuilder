json.extract! advert, :id, :title, :client, :linkurl, :viewcount, :clickcount, :begin_ad, :end_ad, :created_at, :updated_at
json.url advert_url(advert, format: :json)