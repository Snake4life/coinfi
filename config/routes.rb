Rails.application.routes.draw do
  mount Blazer::Engine, at: "blazer"

  devise_scope :user do
    match "/signup" => "users#signup", as: "new_user_signup", via: [:get, :post]
    get "/register" => "users/registrations#new", as: "new_user_registration"
    get "/set-password" => "users#set_password", as: "new_user_set_password"
    post "/submit-password" => "users#submit_password", as: "new_user_submit_password"
    get "/estimate-contribution" => "users#estimate_contribution", as: "new_user_estimate_contribution"
    post "/submit-contribution" => "users#submit_contribution", as: "new_user_submit_contribution"
    get "/join-telegram" => "users#join_telegram", as: "new_user_join_telegram"
    get "/dashboard" => "users#dashboard", as: "new_user_dashboard"
  end
  devise_for :users,
    controllers: {
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    },
    path: '',
    path_names: { sign_in: 'login', sign_out: 'logout'}

  namespace :admin do
    resources :coins
    resources :articles
    resources :users
    post "users/:id/toggle_referral_program" => "users#toggle_referral_program", as: 'toggle_referral_program'
    get 'reddit' => 'articles#reddit'
    root to: "coins#index"
  end

  get '/dashboard', to: 'users#dashboard', as: 'user_root'
  root 'pages#home'

  get '/' => 'pages#home', as: 'home'
  get '/press-release' => 'pages#press'
  get '/about' => 'pages#about'
  get '/contact' => 'pages#contact'
  get '/daily' => 'pages#daily', as: 'daily'
  get '/identify-whale-price-manipulation' => 'pages#identify_whale_price_manipulation'
  get '/detect-coins-about-to-moon' => 'pages#detect_coins_about_to_moon'
  get '/find-relevant-news' => 'pages#find_relevant_news'
  get '/display-research-pieces' => 'pages#display_research_pieces'
  get '/cloak-trading' => 'pages#cloak_trading'
  get '/identify-best-priced-exchange' => 'pages#identify_best_priced_exchange'
  #get '/research-bad-actors' => 'pages#research_bad_actors'
  #get '/facilitate-altcoin-coverage' => 'pages#facilitate_altcoin_coverage'
  #get '/thanks' => 'pages#thanks', as: 'thanks'
  #get '/customize' => 'pages#customize', as: 'customize'
  # post '/subscribe'
  #post '/segment'

  resources :coins, only: [:index, :show]

  get '/historical/:symbol' => 'data#historical'
end
