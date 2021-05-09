class JournalController < ApplicationController

    #create 

    get '/journals/new' do
        erb :'/journals/new'
        #renders journal entry form
    end

    post '/journals' do
        @journal = Journal.create(
            title: params[:title], 
            date: params[:date], 
            entry: params[:entry], 
            mood: params[:mood]
            )
        redirect "journals/#{@journal.id}"
    end

    #read 

    get '/journals/:id' do
        @journal = Journal.find(params[:id])
        erb :'/journals/show'
    end

    get '/journals' do 
        @journals = Journal.all
        erb :'/journals/index'
        
        #returns an array of all instances of this class
    end

    #update 

    get '/journals/:id/edit' do 
        @journal = Journal.find(params[:id])
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