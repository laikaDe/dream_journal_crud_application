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

end
