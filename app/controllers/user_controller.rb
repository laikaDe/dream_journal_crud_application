class UserController < ApplicationController

    

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do

        #   If a user attempts to creates an account with a username that is already taken,
        #   they get redirected back to the signup page.
        #1. Iterate through all users 
        #2. Check each user's usernames with the params[:username] from the 
        #   the signup form 

        @same_username = User.all.any? do |user|
            user.username == params[:username]
        end 


        if params[:username] == "" && params[:password] == ""
            redirect to 'users/signup'
        
        elsif @same_username == true
            redirect to 'users/signup'
        else
            @user = User.create(
                username: params[:username],
                password: params[:password]
                )
                session[:user_id] = @user.id
                redirect "/users/#{@user.id}"
        end
    end

    get '/users/login' do 

        if !logged_in?
            erb :'/users/login'
        else 
            @user = User.find(session[:user_id])
            redirect "/users/#{@user.id}"  
        end
    end

    post '/users/login' do
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else 
            redirect "/users/login"
        end   
    end

    get '/users/:id' do
        
        @user = User.find(params[:id])
        redirect_if_not_logged_in
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end