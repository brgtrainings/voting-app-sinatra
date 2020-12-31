require 'sinatra'
require 'yaml/store'

CHOICES = {
  'HAM' => 'Hamburger',
  'PIZ' => 'Pizza',
  'CUR' => 'Curry',
  'NOO' => 'Noodles'
}


get '/home' do
  erb :index
end 

post '/cast' do
  @title = 'Thanks for casting your vote!'
  @vote  = params['vote']

  # create a votes.yml file and update the particular votes
  @store = YAML::Store.new 'votes.yml'
  @store.transaction do
    @store['votes'] ||= {}
    @store['votes'][@vote] ||= 0
    @store['votes'][@vote] += 1
  end
  erb :cast
end

get '/results' do
  @title = 'Results So Far'
  @store = YAML::Store.new 'votes.yml'
  @votes = @store.transaction { @store['votes'] }
  erb :results
end

get '/' do
  @title = 'Welcome to the Foo Restaurant!'
  erb :'users/signup'
end

post '/' do
  @user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password]
  )
  if @user.username == "" && user.password == ""
    redirect "/users/signup"
  else
    session[:user_id] = @user.id
    redirect to "/login"
  end
end

get '/login' do
  erb :'users/signin'
end

post '/login' do
  user = User.find_by( :username => params[:username])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id 
    redirect to "/home"
  else
    flash[:error] = "Wrong Credentials"
    redirect to '/login'
  end
end



