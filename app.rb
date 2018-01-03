require 'sinatra'
# require 'sinatra/reloader' if development?
require 'erb'
require 'data_mapper'
require 'sinatra/partial'
require 'sinatra/json'
require 'logger'
require 'digest/sha1'
require 'digest/md5'
require 'dm-validations'
require 'date'
require 'pry'
require 'rdiscount'
DataMapper::Logger.new(STDOUT, :debug)
logger = Logger.new(STDOUT)

DataMapper.setup(:default, "mysql://" + ENV["MYSQL_USER"] + ":" + ENV["MYSQL_PWD"] + "@" + ENV["MYSQL_HOST"]  + "/" + ENV["DB_NAME"])



not_found do
  'sorry'
end


configure do
	set :bind, '0.0.0.0'
	# set :port, 1025
	set :public_folder, File.dirname(__FILE__) + '/public'
	enable :sessions
	enable :protection
	enable :logging

end




Dir["./models/*.rb"].each { |file|
	require file
	logger.info("require " +file)
}
DataMapper.finalize
DataMapper.auto_upgrade!
Dir["./init/*.rb"].each { |file|
	require file
	logger.info("require " +file)
}
Dir["./service/*.rb"].each { |file|
	require file
	logger.info("require " +file)
}
Dir["./helpers/*.rb"].each { |file|
	require file
	logger.info("require " +file)
}
Dir["./controllers/*.rb"].each { |file|
	require file
	logger.info("require " +file)
}

# before "/*" do 
#     set :erb, :layout => :layout
# end
