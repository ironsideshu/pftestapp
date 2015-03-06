class DocumentsController < ApplicationController
	
	def signin
		@signin = ""

		if session[:authHeader] != nil
			url = URI.parse('https://pfdatastoredev.cloudant.com/_session')
			http = Net::HTTP.new(url.host, url.port)
			http.use_ssl = true

			req = Net::HTTP::Delete.new(url.request_uri)
			req["Cookie"] = session[:authHeader]
			req["Accept"] = "application/json"
			res = Net::HTTP.start(url.host, url.port) { http.request(req) }
			session[:authHeader] = nil
		end
	end

	def new
		@document = Document.new
	end

	def show
		@memberID = ""
	end

	def update
		@memberID = ""
	end

	def create 
		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = 
		"{\"member_id\":\""+(params[:document])['member_id']+
		"\",\"first_name\":\""+(params[:document])['first_name']+
		"\",\"last_name\":\""+(params[:document])['last_name']+
		"\",\"phone\":\""+(params[:document])['phone']+
		"\",\"email\":\""+(params[:document])['email']+
		"\",\"member_type\":\""+(params[:document])['member_type']+
		"\",\"is_active\":\""+(params[:document])['is_active']+
		"\"}" 

		res = Net::HTTP.start(url.host, url.port) { http.request(req) }
	end



end
