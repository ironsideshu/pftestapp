class ResultsController < ApplicationController
	before_action only: [:modify]
	respond_to :html, :js

	def info
		res = search_member
		@response = (eval(JSON.parse(res.body)["docs"].to_s)).at(0)
		if @response != nil
			@response.each do |elem|
				if elem.at(0) == "BARCODE"
					@barcode = elem.at(1)
					session[:barcode] = @barcode
				end
			end
		end
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
		req.body ="name="+params[:signin]['username']+"&password="+params[:signin]['password']
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = res.get_fields("Set-Cookie")

		if res.get_fields("Set-Cookie") != nil
			session[:authHeader] = res.get_fields("Set-Cookie")
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

		params[:result]['is_active'] == "Active" ? active = "ACT" : active = "INA"

		req.body = 
		"{\"BARCODE\":\""+params[:barcode].upcase+
		"\",\"MEMBER_NUMBER_ORGNL\":\""+params[:member_id]+
		"\",\"MEMBER_FIRST_NAME\":\""+params[:result]['first_name'].upcase+
		"\",\"MEMBER_LAST_NAME\":\""+params[:result]['last_name'].upcase+
		"\",\"PRIMARY_PHONE\":\""+params[:result]['phone'].upcase+
		"\",\"EMAIL_ADDRESS\":\""+params[:result]['email'].upcase+
		"\",\"MEMBER_TYPE\":\""+params[:result]['member_type'].upcase+
		"\",\"STATUS_CODE\":\""+params[:result]['status_code'].upcase+
		"\",\"MEMBER_STATUS_CODE_DESCRIPTION\":\""+params[:result]['status_code_descr']+
		"\",\"ACTIVE_INDICATOR\":\""+active+
		"\",\"PAYMENT_STATUS\":\""+params[:result]['pay_status'].upcase+
		"\",\"_rev\":\""+params[:dbRev]+
		"\"}" 

		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		res.get_fields("Etag") != nil ? params[:dbRev] = res.get_fields("Etag").at(0) : params[:dbRev] = params[:dbRev]
		@status_code = res.code 
		@response = JSON.parse(req.body)
	end

	def search_member
		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test/_find')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = "{\"selector\":{\""+params[:search]["search_type"]+"\":\""+params[:search]["input"].upcase+"\"}}"
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		return res
	end

end
