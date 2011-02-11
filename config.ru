require 'rubygems'
require 'warden'
require './user'
require './testapp'



use Rack::Session::Cookie, :secret => 'whatever'
use Warden::Manager do |manager|
	manager.default_strategies :password
	manager.failure_app = Main::TestApp
	manager.serialize_into_session { |user| user.id }  
	manager.serialize_from_session { |id| User.get(id) } 
end
run Main::TestApp

Warden::Strategies.add(:password) do

  def valid?
    has_parameters = params[:username] || params[:password]

    puts params.class
    puts params.inspect
    puts params.class.ancestors
    puts params.object_id
    puts params[:username].inspect
    puts params[:password].inspect
    puts params[:username] || params[:password]
    puts "password strategy has parameters '#{has_parameters.class}'"

    return has_parameters
  end

  def authenticate!
    puts "authenticating user #{params[:username]}"

    u = User.authenticate(params[:username], params[:password])
    if(u.nil?)
      puts "authentication failed for user #{params[:username]}"

      fail!("Could not log in")
    else
      puts "authentication succeeded for user #{params[:username]}"

      success!(u)
    end
  end
end


