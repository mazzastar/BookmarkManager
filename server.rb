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
require_relative './lib/email_controller.rb'

DataMapper.finalize
DataMapper.auto_upgrade!
	# enable :sessions
	# set :session_secret, 'super-secret'
include Email


class Bookmark < Sinatra::Base
	enable :sessions
	set :session_secret, 'super-secret'
  enable :method_override

	use Rack::Flash

  get '/' do

    puts session[:user_id].nil?

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
		@user = User.new(:email => email, :password => password, :password_confirmation => password_confirmation )
		
		if @user.save
			session[:user_id] = @user.id
			redirect to('/')	
		else
			flash[:errors] = @user.errors.full_messages
			erb :new_users
		end

  end

  get '/sessions/new' do
    # tags = Tag.first(:tagname => params[:text])
    # @links = tags ? tags.links : []
    erb :"sessions/new"
  end

  post '/sessions' do 
    email = params["email"]
    password = params["password"]
    @user = User.authenticate(email, password)
    if @user
      session[:user_id] = @user.id
      redirect to('/')
    else
      flash.now[:errors] = ["Unknown user-password combination"]
      erb :"sessions/new"
    end

  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.now[:notice]= "Goodbye!"
    erb :"sessions/new"
  end

  get '/sessions/recover' do
    erb :"sessions/recover"
  end

  post '/sessions/recover' do 
    email = params[:email]
    user = User.first(email: email)
    
   if user
      user.password_token = (1..64).map{('A'..'Z').to_a.sample}.join
      puts user.password_token
      user.password_token_timestamp = Time.now
      user.save
      
      send_recovery_email( user.password_token, email, request.env["HTTP_HOST"])

      #send an email to the user
      flash[:notice] = "Recovery email sent"


   else
      flash[:notice] = "No email found"
   end
   redirect to "/"

  end

  get "/users/reset_password/:token" do 
    user = User.first(password_token: params[:token])
    if user.nil?
      flash[:notice] = "Invalid Token"
      redirect to '/sessions/recover'
    elsif Time.parse(user.password_token_timestamp.to_s)+3600  > Time.now
      @token = params[:token]
      erb :"password/reset_password"
    else
       flash[:notice] = "Token not used within the hour"
       redirect to '/sessions/recover'
    end

  end

  post "/users/reset_password" do 
    puts params.inspect
    begin 
      params[:password] == params[:password_confirmation]
      user = User.first(password_token: params[:token])
      user.password_digest = BCrypt::Password.create(params[:password])
      user.password_token = nil
      user.password_token_timestamp = nil
      user.save
      flash[:notice] = "Password changed successfully, please log in again"
      erb :"sessions/new"

    rescue
      flash[:notice] = "Unsuccessful change, please try again"
      redirect to '/sessions/recover'
    end
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
