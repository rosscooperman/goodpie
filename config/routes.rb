ActionController::Routing::Routes.draw do |map|
  map.resources :projects do |project|
    project.resources :builds
  end

  map.root :controller => "projects"
end
