class JournalController < ApplicationController

    #create 

    get '/journals/new' do
        erb :'/journals/new'
        #renders journal entry form
    end

    post '/journals' do
        
        @user = User.find(session[:user_id])
        binding.pry
        if @user
            @journal = Journal.create(
            title: params[:title], 
            user_id: session[:user_id],
            date: params[:date], 
            entry: params[:entry], 
            mood: params[:mood]
            )
            redirect "journals/#{@journal.id}"
        else
            redirect "/login"
        end
    end

    #read 

    get '/journals/:id' do
        @journal = Journal.find_by_id(params[:id])
        erb :'/journals/show'
    end

    get '/journals' do 
        #Iterate through all journals and filter 
        #the journals with the current user id
        #1. Iterate through all journals
        #2. Filter out the current user id 
        #3. Store the journals with the current user id in a variable
        @journals = Journal.all
        @journals = @journals.select {|journal|journal.user_id == session[:user_id]}
        erb :'/journals/index'
        
        #returns an array of all instances of this class
    end

    #update 

    get '/journals/:id/edit' do 
        @journal = Journal.find_by_id(params[:id])
        erb :'/journals/edit'
    end

    patch '/journals/:id' do 
        @journal = Journal.find(params[:id])
        @journal.update(
            title: params[:title],
            date: params[:date], 
            entry: params[:entry], 
            mood: params[:mood]
            )
        redirect "journals/#{@journal.id}"
    end

    #delete

    delete '/journals/:id' do 
        @journal = Journal.find(params[:id])
        @journal.destroy
        redirect '/journals'
    end


end