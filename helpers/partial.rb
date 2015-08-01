helpers do
	def partial template
	  erb template, :layout => false
	end
	alias_method :h, :escape_html
end