Rails.application.routes.draw do
  #devise_for :admins
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations' }
  resources :adverts
  resources :admin_dashboards
  get 'matches', to: 'admin_dashboards#matches'
  resources :admin_offers
  resources :admin_seeks

  get 'departurelog', to: 'adverts#departurelog', as: 'adverts_departurelog'
  get 'destinationlog', to: 'adverts#destinationlog', as: 'adverts_destinationlog'

  get 'message_counter', to: 'offers#get_messagecount', as: 'message_counter'
  resources :sessions, only: [:create, :destroy]

  get 'mitfahrgelegenheit/:id', to: 'offers#show', as: 'offers_mitfahrgelegenheit'
  get 'mitfahrgelegenheit/:offer_id/anschreiben', to: 'messages#new', as: 'offers_new_message'

  resources :messages do
    resources :answers
  end

  get 'nachricht/:id/gelesen', to: 'messages#markread', as: 'markread'
  get 'mitfahrgelegenheiten', to: 'offers#all', as: 'offers_mitfahrgelegenheiten'
  get 'mitfahrgelegenheit/:id/bearbeiten', to: 'offers#edit', as: 'edit_offer_mitfahrgelegenheit'

  get 'neu', to: 'offers#new', as: 'neu'

  get 'adclick/:id', to: 'offers#adclick', as: 'adclick'
  resources :offers do
    get :autocomplete_cityname_name, :on => :collection
  end
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'logincheck', to: 'home#logincheck', as: 'logincheck'


  get 'suchen', to: 'offers#search', as: 'offers_search'

  get 'finden', to: 'offers#find', as: 'offers_find'
  get 'konto', to: 'offers#overview', as: 'offers_overview'

  get 'weiterleitung/:offerid/:facebookid', to: 'offers#linkout', as: 'offers_linkout'

  get 'nachricht/:offerid', to: 'offers#msglinkout', as: 'offers_msglinkout'

  get 'login', to: 'home#login', as: 'home_login'
  get 'agb_datenschutz', to: 'home#agbdatenschutz', as: 'home_agbdatenschutz'
  get 'impressum', to: 'home#impressum', as: 'home_impressum'
  get 'hitchiwas', to: 'home#explain', as: 'home_explain'

  resource :home, only: [:show]

  get 'sitemap', to: 'home#sitemap', as: 'home_sitemap'
  
  root to: "home#show"
end
