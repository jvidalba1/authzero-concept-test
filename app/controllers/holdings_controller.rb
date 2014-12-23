class HoldingsController < ApplicationController
	def index
	    @access_token = "4b46a7df247d5a9b5e8a0a3cd7732b2f87eab2b8c4da40555da5c0f0eea864cb"
	    response = HTTParty.get("https://investor.api.fcstaging.us/api/v1/holdings?access_token=#{@access_token}", :verify => false)
	    @holdings = response.parsed_response["_embedded"]["holdings"]
	end
end
