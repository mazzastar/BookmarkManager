require 'sinatra/base'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"
DataMapper.setup(:default, "postgres://localhost/bookmark_manager_#{env}")
require './lib/link'
require './lib/tag'

DataMapper.finalize
DataMapper.auto_upgrade!

class Bookmark < Sinatra::Base
  get '/' do
    @links = Link.all
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
		puts url.inspect
		Link.create(:url => url, :title => title, :tags => tags)
	  	redirect to("/")
	 end

	get '/users/new' do 
  	erb :new_users
  end

  post '/users/new' do
  	email = params["email"]
  	password = params["password"]
  	puts email
  	puts password
  	# User.create(:email => email, :password => password)
  end


  # start the server if ruby file executed directly
  run! if app_file == $0



end
