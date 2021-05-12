class JournalController < ApplicationController

    #create 

    get '/journals/new' do
        erb :'/journals/new'
        #renders journal entry form
    end

    post '/journals' do

        #1. Finds the user_id in session and save that into an 
        #   instance variable 
        #2. Check if @user exists 
        #3. If it does create a new Journal object and store it's 
        # values into params as well as it's user_id into session 
        #4. redirect "journals/#{@journal.id}"
        #5. redirect "/login"
        
        @user = User.find(session[:user_id])
        if @user
            if params[:title] == "" 
                redirect "journals/new"
            else
                @journal = Journal.create(
                title: params[:title], 
                user_id: session[:user_id],
                date: params[:date], 
                entry: params[:entry], 
                mood: params[:mood]
                )
                redirect "journals/#{@journal.id}"
            end
        else
            redirect "/login"
        end
    end

    #read 


    get '/journals/:id' do

        #1. Takes in user_id through params and stores this in instance variable
        #2. Sends that data to showpage
        #3. Renders the data back to user 
        @journal = Journal.find_by_id(params[:id])
        erb :'/journals/show'
    end

    get '/journals' do 
        #1. Iterates through all journals and filters 
        #   the journals that is equal to the current user id
        #2. Iterates through all journals
        #3. Filters out the current user id 
        #4. Stores the journals with the current user id in a variable
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