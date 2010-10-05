ActionController::Routing::Routes.draw do |map|

  map.root :controller => "home"

  map.map_tweets '/map/:user',         :controller => 'tweets_map', :action => 'map', :conditions => { :method => :get }

#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'
end
