require 'rubygems'
require 'warden'
require './user'
require './testapp'

Warden::Strategies.add(:password) do

  def valid?
    params[:username] || params[:password]
  end

  def authenticate!
    u = User.authenticate(params[:username], params[:password])
    u.nil? ? fail!("Could not log in") : success!(u)
  end
end

use Rack::Session::Cookie, :secret => 'whatever'
use Warden::Manager do |manager|
	manager.default_strategies :password
	manager.failure_app = Main::TestApp
	manager.serialize_into_session { |user| user.id }  
	manager.serialize_from_session { |id| User.get(id) } 
end
run Main::TestApp


