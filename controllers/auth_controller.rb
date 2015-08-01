
post '/signin' do
	if session[:user] = User.authenticate(params[:email], params[:password])
 
	    redirect '/home'
	else
	    redirect '/signin'
	end
end



post '/signup' do
	new_user = User.new
	new_user.user_id = params[:user_id]
	new_user.password = params[:password]
	new_user.email = params[:email]
	new_user.first_name = params[:first_name]
	new_user.last_name = params[:last_name]
	if new_user.save
  	redirect '/signin'
	else
  	tmp = []
  	new_user.errors.each do |e|
    		tmp << (e.join("<br/>"))
  	end
  	logger.info(tmp)
  	erb :signup
	end
end
 
