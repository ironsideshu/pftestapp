class DocumentsController < ApplicationController
	before_action only: [:show]
	respond_to :html, :js

	def signin
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
	end

	def create 
		params[:document]['is_active'] == "Active" ? active = "ACT" : active = "INA"

		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = 
		"{\"BARCODE\":\""+params[:document]['barcode'].upcase+
		"\",\"MEMBER_NUMBER_UNIQUE\":\""+params[:document]['member_id'].upcase+
		"\",\"MEMBER_FIRST_NAME\":\""+params[:document]['first_name'].upcase+
		"\",\"MEMBER_LAST_NAME\":\""+params[:document]['last_name'].upcase+
		"\",\"PRIMARY_PHONE\":\""+params[:document]['phone'].upcase+
		"\",\"EMAIL_ADDRESS\":\""+params[:document]['email'].upcase+
		"\",\"MEMBER_TYPE\":\""+params[:document]['member_type'].upcase+
		"\",\"STATUS_CODE\":\""+params[:document]['status_code'].upcase+
		"\",\"MEMBER_STATUS_CODE_DESCRIPTION\":\""+params[:document]['status_code_descr']+
		"\",\"ACTIVE_INDICATOR\":\""+active+
		"\",\"PAYMENT_STATUS\":\""+params[:document]['pay_status']+
		"\"}" 

		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = JSON.parse(req.body)
	end

end
