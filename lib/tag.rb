class Tag
	include DataMapper::Resource

	property :id, Serial
	property :tagname, String
	has n, :links, :through => Resource
end

# DataMapper.finalize
 # DataMapper.auto_migrate!
# DataMapper.auto_upgrade!
