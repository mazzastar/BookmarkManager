

class Link
	include DataMapper::Resource

	property :id, Serial
	property :title, String
	property :url, String
	property :description, Text

	belongs_to :user
	has n, :tags, :through => Resource
end
 # DataMapper.finalize
 # DataMapper.auto_migrate!
 # DataMapper.auto_upgrade!

