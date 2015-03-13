class PerksController < ApplicationController
	before_action only: [:new]
	respond_to :html, :js

	def add_perk
		@perk = Perk.new
	end

	def create
		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = 
		"{\"MEMBER_BARCODE\":\""+session[:barcode]+
		"\",\"AFFINITY_PROGRAM\":\""+params[:perk]['program'].upcase+
		"\",\"AFFINITY_BRAND\":\""+params[:perk]['brand'].upcase+
		"\",\"PERK_NAME\":\""+params[:perk]['perk_name'].upcase+
		"\",\"PERK_DESCRIPTION\":\""+params[:perk]['perk_descr'].upcase+
		"\",\"PERK_OPEN_DATE_TIME\":\""+params[:perk]['open_time'].upcase+
		"\",\"PERK_CLICK_DATE_TIME\":\""+params[:perk]['click_time'].upcase+
		"\",\"PERK_REDEEMED_DATE_TIME\":\""+params[:perk]['redeemed_time'].upcase+
		"\",\"PERK_REDEEMED_LOCATION\":\""+params[:perk]['redeemed_loc'].upcase+
		"\",\"PERK_GROSS_REVENUE_AMOUNT\":\""+params[:perk]['gross_amt'].upcase+
		"\",\"PERK_DISCOUNT_AMOUNT\":\""+params[:perk]['discount_amt'].upcase+
		"\",\"IS_PERK\":\""+"TRUE"+
		"\"}" 

		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = JSON.parse(req.body)
	end

	def view_perks
		url = URI.parse('https://pfdatastoredev.cloudant.com/pf_db_test/_find')
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true

		req = Net::HTTP::Post.new(url.request_uri)
		req["content-type"] = "application/json"
		req["cookie"] = session[:authHeader]
		req.body = "{\"selector\":{\"MEMBER_BARCODE\":\""+session[:barcode]+"\",\"IS_PERK\":\"TRUE\"}}"
		res = Net::HTTP.start(url.host, url.port) { http.request(req) }

		@response = (eval(JSON.parse(res.body)["docs"].to_s))
	end
end