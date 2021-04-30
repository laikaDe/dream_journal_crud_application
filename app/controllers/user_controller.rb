class UserController < ApplicationController

    get '/users/signup' do
        erb :'/users/signup'
    end

    post '/users/signup' do
        #get params from our form 
        #params hash is created automatically 
        #get this params by using params.inspect
        @user = User.create(username:params[:username], password: params[:password])
        redirect "/users/#{@user.id}"
    end

    get '/users/:id' do
        #looks at once instance of user 
        #showpage => page where one renders data of just one instance 
        @user = User.find(params[:id])
        erb :'/users/show'
    end
end