ActionController::Routing::Routes.draw do |map|
  map.resources :projects
  # map.resources :builds

  map.root :controller => "projects"
end
