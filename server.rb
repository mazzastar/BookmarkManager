# enable :sessions
# set :session_secret

require 'sinatra/base'
require 'data_mapper'
require 'sinatra'
require 'rack-flash'

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
	use Rack::Flash



  get '/' do
    @links = Link.all
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
		Link.create(:url => url, :title => title, :tags => tags)
	  redirect to("/")
	 end

	get '/users/new' do 
		@user = User.new
  	erb :new_users
  end

  post '/users' do
  	email = params["email"]
  	password = params["password"]
  	password_confirmation = params["password_confirmation"]
		@user = User.new(:email => email, :password => password, :password_confirmation =>password_confirmation )
		
		if @user.save
			session[:user_id] = @user.id
			redirect to('/')	
		else
			flash[:errors] = @user.errors.full_messages
			erb :new_users
		end

  end

  helpers do
  	def current_user 
  		@current_user||= User.get(session[:user_id])if session[:user_id]
  	end
  end


  # start the server if ruby file executed directly
  run! if app_file == $0



end
