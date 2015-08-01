get '/signin' do
	erb :signin
end
get '/signup' do
	erb :signup
end
get '/signout' do
	session[:user] = nil
	session[:project] = nil
	redirect '/'
end
get '/' do
	 
	erb :index
end
get '/home' do
	erb :home
end



