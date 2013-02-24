#!/usr/bin/ruby

require 'rubygems'
require 'json'
require 'net/http'

url = 'http://www.temporealeataf.it/Mixer/Rest/PublicTransportService.svc/schedule?callback=bus&nodeID=FM1926&lat=43.79937&lon=11.27518&timeZone=%2B1&s=e310fcc7ae7a5d6901a53808006c4705bc776c7b&_=1361694617588'

resp = Net::HTTP.get_response(URI.parse(url))

busjson = resp.body
busjson.sub!("bus(","")
busjson.sub!("[","") # Do this separately so we capture null
busjson.sub!("]","")
busjson.sub!(");","")
if busjson=="null" or busjson=="" or busjson==" "
	puts "No info. Bus probably just passed. Check again in a few minutes."
else
	data=JSON.parse(busjson)
	time=Time.at(data['d'].to_i/1000).strftime('%R')
	puts "Next Bus: #{time}"
end
