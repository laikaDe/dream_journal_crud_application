require './config/environment'

class ApplicationController < Sinatra::Base

  configure do

    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    set :method_override, true
    register Sinatra::Flash
    
  end

  get "/" do
    redirect_if_logged_in
    erb :welcome
  end

  helpers do 
    
    #return a true or a false value
    def logged_in? 
      !!session[:user_id] #negating twice -> turns it into a boolean
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    # use this helper method to protect controller actions where user must be logged in to proceed
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

    def authorized_to_edit?(journal)
      journal.user == current_user
    end

    # use this helper method to avoid showing welcome, login, or signup page to a user that's already logged in
    def redirect_if_logged_in
      if logged_in?
        redirect "/users/#{current_user.id}"
      end
    end
  end
end