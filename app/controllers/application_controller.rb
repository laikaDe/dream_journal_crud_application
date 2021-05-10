require './config/environment'

class ApplicationController < Sinatra::Base

  configure do

    set :public_folder, 'public'
    #set sessions
    set :views, 'app/views'
    enable :sessions
    set :sessions_secret, "secret"
    set :method_override, true
  end

  get "/" do
    erb :welcome
  end

  helpers do 

    def logged_in? #return a true or a false value
      !!session[:user_id] #negating twice -> turns it into a boolean
    end
  end

end
