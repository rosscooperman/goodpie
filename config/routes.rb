Goodpie::Application.routes.draw do

  resources :projects do
    resources :builds
    resources :steps
  end

  root :to => 'projects#index'

end
