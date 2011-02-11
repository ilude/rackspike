require 'sinatra/base'
require 'erb'
require 'rack-flash'
require 'padrino-helpers'

module Main
  class TestApp < Sinatra::Base
    use Rack::Flash
    register Padrino::Helpers

    set :sessions, true

    get "/" do
      puts "root get request"

      if env['warden'].user
        erb :index
      else
        redirect '/login'
      end
    end

    get '/login/?' do
      puts "login get request"

      erb :login
    end

    post '/login/?' do
      puts "login post request"

      puts params.class
      puts params.inspect
      puts params.class.ancestors
      puts params.object_id
      puts params[:username].inspect
      puts params[:password].inspect

      puts "login post request"
      env['warden'].authenticate!
      redirect "/"
    end

    get '/logout/?' do
      puts "logout get request"

      env['warden'].logout
      redirect '/'
    end

    post '/unauthenticated/?' do
      puts "unauth post request"

      status 410
      "Could not login"
    end
  end
end