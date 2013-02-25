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
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-san-domenico/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=SAN+DOMENICO&Fermata=FM0380&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=d")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	elsif whichstop=='sdnorth'
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-san-domenico-01---european-university/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=SAN+DOMENICO+01+-+EUROPEAN+UNIVERSITY&Fermata=FM0370&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	elsif whichstop=='fiesole'
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-fiesole---vinandro-osteria/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=FIESOLE+-+VINANDRO+OSTERIA&Fermata=FM0375&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=d")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	elsif whichstop=='sm1'
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-san-marco---gran-caffe--san-marco/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=SAN+MARCO+-+GRAN+CAFFE%27+SAN+MARCO&Fermata=FM0084&idC=180&idO=0&Linea=1&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	elsif whichstop=='sm7'
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-la-pira/#{daystring}/timetables.aspx?date=25%2f02&dateHash=078d5c8334e82266787a17aae62fa357&DescrFermata=LA+PIRA&Fermata=FM1884&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	elsif whichstop=='smn'
		page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-stazione-deposito-bagagli/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=STAZIONE+DEPOSITO+BAGAGLI&Fermata=FM0019&idC=180&idO=0&Linea=1&LN=en-US&Orario=#{orario}&#Servizio=#{servizio}&Tmp=0&Verso=a")
		mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
		return mytable
	else
		mytable=nil
	end
end
set :raise_errors => true
set :show_exceptions => true
get '/' do
	"
	<!doctype html>
	<html lang='en'>
	<head>
		<meta charset='utf-8'>
		<meta name='viewport' content='width=320, initial-scale=1.0, user-scalable=no' />
		<link rel='stylesheet' href='style/style.css'>
		  <!--[if lt IE 9]>
			  <script src='http://html5shiv.googlecode.com/svn/trunk/html5.js'></script>
		  <![endif]-->
	</head>
<body>
	<h1>Busses Near EUI</h1><br /><br />
	<h2>San Domenico</h2>
	<p>
		<a href='/sdsouth'>Bus 7 to Downtown</a>
		<a href='/sdnorth'>Bus 7 to Fiesole</a>
	</p>

	<h2>Near EUI Flats</h2>
	<p>
		<a href='/flats'>Bus 1A From Salviati to S.M.N. Train Station</a>
	</p>
	<h2>Piazza San Marco</h2>
	<p>
		<a href='/sm7'>Bus 7 to EUI and Fiesole</a>
		<a href='/sm1'>Bus 1A/B to Lapo and Boccaccio (Alternate)</a>
	</p>	

	<h2>S.M.N. Train Station</h2>
	<p>
		<a href='/smn'>Bus 1A/B to Lapo and Boccaccio (Alternate)</a>
	</p>
	<h2>Fiesole</h2>
	<p>
		<a href='/fiesole'>Bus 7 to San Domenico and San Marco</a>
	</p>
</body>
</html>
end

get '/*' do
	@tabledata=getpage(params[:splat],a)
	erb :index
end
