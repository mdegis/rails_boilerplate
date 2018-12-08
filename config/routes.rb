Rails.application.routes.draw do
  use_doorkeeper
  mount API::Base, at: "/"
  mount GrapeSwaggerRails::Engine, at: "/documentation"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: { unlocks: "unlocks" }
  root to: "home#index"
end
