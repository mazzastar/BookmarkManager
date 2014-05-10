# enable :sessions
# set :session_secret

require 'sinatra/base'
require 'data_mapper'
require 'sinatra'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
require './lib/link'
require './lib/tag'
require './lib/user'

DataMapper.finalize
DataMapper.auto_upgrade!
	# enable :sessions
	# set :session_secret, 'super-secret'


class Bookmark < Sinatra::Base
	enable :sessions
	set :session_secret, 'super-secret'


  get '/' do

  	puts "Session id in  homepage is #{session[:user_id].inspect}"

    @links = Link.all
    puts "checking email"
    puts User.first.inspect
    @email = User.first.email if !User.first.nil?
    erb :index
  end

  get '/tags/:text' do
  	tags = Tag.first(:tagname => params[:text])
  	@links = tags ? tags.links : []
  	erb :index
  end
  	
  

  post '/' do
  	tags = params["tags"].split(" ").map do |tag|
  		Tag.first_or_create(:tagname => tag)
		end

		url = params[:url]
		title = params[:title]
		# puts url.inspect
		Link.create(:url => url, :title => title, :tags => tags)
	  	redirect to("/")
	 end

	get '/users/new' do 
		puts "Sign up"
  	erb :new_users
  end

  post '/users' do
  	email = params["email"]
  	password = params["password"]
  	password_confirmation = params["password_confirmation"]
		user = User.create(:email => email, :password => password, :password_confirmation =>password_confirmation )		
		session[:user_id] = user.id
		redirect to('/')	
  	 	# User.create(:email => email, :password => password)
  end

  helpers do
  	def current_user 
  		@current_user||= User.get(session[:user_id])if session[:user_id]
  	end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0



end
