class JournalController < ApplicationController

    #create 

    get '/journals/new' do
        erb :'/journals/new'
    end

    post '/journals' do

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
        @journal = Journal.find_by_id(params[:id])
        erb :'/journals/show'
    end

    get '/journals' do 
        if logged_in?
            @user = current_user
            @journals = @user.journals
            erb :'/journals/index'
        end
    end

    #update 

    get '/journals/:id/edit' do 
        @journal = Journal.find_by_id(params[:id])
        if authorized_to_edit?(@journal)
            erb :'/journals/edit'
        else
            redirect "users/#{current_user.id}"
        end
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
        if authorized_to_edit?(@journal)
            @journal.destroy
        else
            redirect "users/#{current_user.id}"
        end
    end
end