class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @user = User.find_by(:id => session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params.value?("")
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(:content => params[:content])
      @tweet.user_id = session[:user_id]
      @tweet.save
      redirect :"/tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/edit_tweet'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(:id => params[:id])
    if params.value?("")
      redirect "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(:content => params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if logged_in? && @tweet.user_id == session[:user_id]
      @tweet.delete
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
