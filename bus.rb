#!/usr/bin/ruby

require 'rubygems'
require 'mechanize'

URL_PATTERN = "http://www.ataf.net/en/timetables-and-routes/timetables-and-routes"+
  "/line-1/stop-salviati-fs/DAYSTRING/timetables.aspx?date=24%2f02&"+
  "DescrFermata=FERMATA_NAME&Fermata=FERMATA_CODE&idC=180&idO=0&Linea=LINEA"+
  "&LN=en-US&Orario=ORARIO&Servizio=SERVIZIO&Tmp=0&Verso=d".freeze

def getvars()
  weekday=(Time.now.getgm+3600).wday
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
  { "daystring"=>daystring,"servizio"=>servizio,"orario"=>orario }
end

def url(daystring, fermata_name, fermata_code, linea, orario, servizio)
  result = URL_PATTERN.dup
  [ [daystring, 'DAYSTRING'],
    [fermata_name, 'FERMATA_NAME'],
    [fermata_code, 'FERMATA_CODE'],
    [linea, 'LINEA'],
    [orario, 'ORARIO'],
    [servizio, 'SERVIZIO']].each do |value, pattern|
    result.sub!(pattern, value)
  end
  result
end

def getpage(whichstop)
  whichstop=whichstop[0]
  # Check if cache has this already:
  if File.exists?("cache/#{whichstop}.cache")
    if Time.now-File.mtime("cache/#{whichstop}.cache")<3480
      # The cache is less than 58 minutes old, uses it
      return contents = File.open("cache/#{whichstop}.cache", 'rb') { |f| f.read } # !> assigned but unused variable - contents
    end
  end
  a=Mechanize.new { |agent| agent.user_agent_alias='Mac Safari'}
  vars=getvars()
  daystring=vars["daystring"]
  servizio=vars["servizio"]
  orario=vars["orario"]

  if whichstop=='flats'
    page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-salviati-fs/#{daystring}/timetables.aspx?date=24%2f02&DescrFermata=SALVIATI+FS&Fermata=FM1926&idC=180&idO=0&Linea=1&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=d")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  elsif whichstop=='sdsouth'
    page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-san-domenico/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=SAN+DOMENICO&Fermata=FM0380&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=d")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  elsif whichstop=='sdnorth'
    page=a.get("http://www.ataf.net/it/orari-e-percorsi/orari-e-linee/line-7/stop-san-domenico-01---european-university/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=SAN+DOMENICO+01+-+EUROPEAN+UNIVERSITY&Fermata=FM0370&idC=180&idO=0&Linea=7&LN=it-IT&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioATrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  elsif whichstop=='fiesole'
    page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-fiesole---vinandro-osteria/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=FIESOLE+-+VINANDRO+OSTERIA&Fermata=FM0375&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=d")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioDTrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  elsif whichstop=='sm1'
    page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-san-marco---gran-caffe--san-marco/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=SAN+MARCO+-+GRAN+CAFFE%27+SAN+MARCO&Fermata=FM0084&idC=180&idO=0&Linea=1&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioATrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  elsif whichstop=='sm7'
    page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-7/stop-la-pira/#{daystring}/timetables.aspx?date=25%2f02&dateHash=078d5c8334e82266787a17aae62fa357&DescrFermata=LA+PIRA&Fermata=FM1884&idC=180&idO=0&Linea=7&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioATrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  elsif whichstop=='smn'
    page=a.get("http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-stazione-deposito-bagagli/#{daystring}/timetables.aspx?date=25%2f02&DescrFermata=STAZIONE+DEPOSITO+BAGAGLI&Fermata=FM0019&idC=180&idO=0&Linea=1&LN=en-US&Orario=#{orario}&Servizio=#{servizio}&Tmp=0&Verso=a")
    mytable=page.search '//*[@id="ctl00_ContentPlaceHolderMain_GridViewOrarioATrasposto"]'
    File.open("cache/#{whichstop}.cache", 'w') {|f| f.write(mytable) }
    return mytable
  else
    mytable=nil
  end
end

if __FILE__ == $0
  require 'rspec/autorun'

  describe "url" do
    it "should work" do
      url('daystring', 'fermata_name', 'fermata_code', 'linea', 'orario', 'servizio').should == \
      "http://www.ataf.net/en/timetables-and-routes/timetables-and-routes/line-1/stop-salviati-fs/daystring/timetables.aspx?date=24%2f02&DescrFermata=fermata_name&Fermata=fermata_code&idC=180&idO=0&Linea=linea&LN=en-US&Orario=orario&Servizio=servizio&Tmp=0&Verso=d"
    end
  end
end
