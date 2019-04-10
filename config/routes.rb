Rails.application.routes.draw do
  devise_for :users, modules: "users"
  devise_for :admins, controllers: { sessions: 'admins/sessions', registrations: 'admins/registrations' }

  namespace :admins do
    resources :dashboards
    resources :offers
    resources :seeks
    resources :adverts
    # logs
    get 'departurelog', to: 'adverts#departurelog', as: 'adverts_departurelog'
    get 'destinationlog', to: 'adverts#destinationlog', as: 'adverts_destinationlog'
  end

  resource :home, only: [:show]
  get 'agb_datenschutz', to: 'home#agbdatenschutz', as: 'home_agbdatenschutz'
  get 'impressum', to: 'home#impressum', as: 'home_impressum'
  get 'hitchiwas', to: 'home#explain', as: 'home_explain'
  get 'sitemap', to: 'home#sitemap', as: 'home_sitemap'

  get 'login', to: 'home#login', as: 'home_login'
  get 'logincheck', to: 'home#logincheck', as: 'logincheck'
  get 'konto', to: 'offers#overview', as: 'offers_overview'

  get 'mitfahrgelegenheiten', to: 'offers#all', as: 'offers_mitfahrgelegenheiten'
  get 'mitfahrgelegenheit/:id', to: 'offers#show', as: 'offers_mitfahrgelegenheit'
  get 'mitfahrgelegenheit/:offer_id/anschreiben', to: 'messages#new', as: 'offers_new_message'
  get 'mitfahrgelegenheit/:id/bearbeiten', to: 'offers#edit', as: 'edit_offer_mitfahrgelegenheit'
  get 'neu', to: 'offers#new', as: 'neu'
  get 'suchen', to: 'offers#search', as: 'offers_search'
  get 'finden', to: 'offers#find', as: 'offers_find'

  get 'nachricht/:id/gelesen', to: 'messages#markread', as: 'markread'
  get 'nachricht/:offerid', to: 'offers#msglinkout', as: 'offers_msglinkout'
  get 'message_counter', to: 'offers#get_messagecount', as: 'message_counter'
  resources :messages do
    resources :answers
  end

  get 'adclick/:id', to: 'offers#adclick', as: 'adclick'
  resources :offers do
    get :autocomplete_cityname_name, :on => :collection
  end
  get 'weiterleitung/:offerid/:facebookid', to: 'offers#linkout', as: 'offers_linkout'

  root to: "home#show"
end
