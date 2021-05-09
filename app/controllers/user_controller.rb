class UserController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        #get params from our form 
        #params hash is created automatically 
        #get this params by using params.inspect
        @user = User.create(
            username:params[:username],
            password: params[:password]
            )
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
    end

    get '/users/login' do 
        #if the user is logged in 
        #redirect to their homepage
        #else, show them the login form
        erb :'users/login'
    end

    post '/users/login' do
        #want to find the user if it exists 
         @user = User.find_by(username: params[:username])
        #if user exists => authenticate password
        
            
    end

    get '/users/:id' do
        #looks at once instance of user 
        #showpage => page where one renders data of just one instance 
        @user = User.find(params[:id])
        erb :'/users/show'
    end
end