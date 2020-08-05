Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get "/:slug" => "links#redirect", as: :shortened_link
  resources :links, only: [:index, :create, :show], param: :slug
  root to: "home#index"
end
