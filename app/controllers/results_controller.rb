class ResultsController < ApplicationController
	def info
		id = params[:member_id]

		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test/_find')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = "{\"selector\":{\"member_id\":\""+id+"\"}}"
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = (eval(JSON.parse(res.body)["docs"].to_s)).at(0)
	end

	def edit
		@document = Document.new

		id = params[:member_id]

		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test/_find')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = "{\"selector\":{\"member_id\":\""+id+"\"}}"
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = (eval(JSON.parse(res.body)["docs"].to_s)).at(0)
	end

	def menu
		url = URI.parse('https://pfdatastoredev.cloudant.com/_session')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/x-www-form-urlencoded"
		req.body ="name="+params['username']+"&password="+params['password']
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = res.get_fields("Set-Cookie")

		if res.get_fields("Set-Cookie") != nil
			session[:authHeader] = res.get_fields("Set-Cookie")
			#session[:auth] = res.get_fields("Set-Cookie").first.split(";").first.split("=").last
		else
			redirect_to :controller => 'documents', :action => 'signin'
		end
	end
end
