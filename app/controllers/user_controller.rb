class UserController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        #get params from our form 
        #params hash is created automatically 
        #get this params by using params.inspect

        if params[:username] == "" && params[:password] == ""
            redirect "/users/signup"
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
        #if the user is logged in 
        #redirect to their homepage
        #else, show them the login form
        if !logged_in?
            erb :'/users/login'
        else 
            @user = User.find(session[:user_id])
            redirect "/users/#{@user.id}"  
        end
    end

    post '/users/login' do
        #want to find the user if it exists 
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
            #authenticate password 
            #start session
            #direct to homepage
        else 
            #not valid 
            #redirect to login again 
            redirect "/users/login"
        end
        #if user exists => authenticate password      
    end

    get '/users/:id' do
        #looks at once instance of user 
        #showpage => page where one renders data of just one instance
        
        @user = User.find(params[:id])
        redirect_if_not_logged_in
        erb :'/users/show'
    end

    get '/logout' do
        session.clear
        redirect '/'
    end
end