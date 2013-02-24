#!/usr/bin/ruby

require 'rubygems'
require 'mechanize'
def getvars()
	weekday=Time.now.wday
	if weekday==0
		# Sunday
		daystring='festivi'
		servizio='5'
		orario='0'
	elsif weekday==6
		# Saturday
		daystring='sabato'
		servizio='4'
		orario='1'
	else
		# Weekday
		daystring='feriali'
		servizio='3'
		orario='2'
	end
	return Hash["daystring"=>daystring,"servizio"=>servizio,"orario"=>orario]
end

a=Mechanize.new { |agent| agent.user_agent_alias='Mac Safari'}   

def getpage(whichstop,a)
	whichstop=whichstop[0]
	vars=getvars()
	daystring=vars["daystring"]
	servizio=vars["servizio"]
	orario=vars["orario"]
	if whichstop=='flats'
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-salviati-fs/#{daystring}/timetables.aspx?date=24%2f02&DescrFermata=SALVIATI+FS&Fermata=FM1926&idC=180&idO=0&Linea=1&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=d")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	elsif whichstop=='sdsouth'
		mytable=nil
	elsif whichstop=='sdnorth'
		mytable=nil
	elsif whichstop=='sm7'
		mytable='TEST'
	elsif whichstop=='sm1a'
		mytable=nil
	elsif whichstop=='sm1b'
		mytable=nil
	elsif whichstop=='smn1a'
		mytable=nil
	elsif whichstop=='smn1b'
		mytable=nil
	else
		mytable=nil
	end
end
set :raise_errors => true
set :show_exceptions => true
get '/' do
	"<h1>Busses Near EUI</h1><br /><br />
	<a href='/flats'>Bus 1A From Salviati to Santa Maria Novella</a>"
end

get '/*' do
	@tabledata=getpage(params[:splat],a)
	erb :index
end
