class ResultsController < ApplicationController
	def info
		res = search_member

		@response = (eval(JSON.parse(res.body)["docs"].to_s)).at(0)
	end

	def modify
	end

	def edit
		@changes = Result.new

		res = search_member

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

	def create
		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test/'+params[:dbID])
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Put.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]

		(params[:result])['is_active'] == "Active" ? active = "ACT" : active = "INA"

		req.body = 
		"{\"BARCODE\":\""+(params[:barcode])+
		"\",\"MEMBER_NUMBER_ORGNL\":\""+params[:member_id]+
		"\",\"MEMBER_FIRST_NAME\":\""+(params[:result])['first_name']+
		"\",\"MEMBER_LAST_NAME\":\""+(params[:result])['last_name']+
		"\",\"PRIMARY_PHONE\":\""+(params[:result])['phone']+
		"\",\"EMAIL_ADDRESS\":\""+(params[:result])['email']+
		"\",\"MEMBER_TYPE\":\""+(params[:result])['member_type']+
		"\",\"STATUS_CODE\":\""+(params[:result])['status_code']+
		"\",\"MEMBER_STATUS_CODE_DESCRIPTION\":\""+(params[:result])['status_code_descr']+
		"\",\"ACTIVE_INDICATOR\":\""+active+
		"\",\"PAYMENT_STATUS\":\""+(params[:result])['pay_status']+
		"\",\"_rev\":\""+params[:dbRev]+
		"\"}" 

		res = Net::HTTP.start(url.host, url.port) { http.request(req) }
	end

	def search_member
		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test/_find')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = "{\"selector\":{\""+params[:search]["search_type"]+"\":\""+params[:search]["input"]+"\"}}"
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		return res
	end
end
