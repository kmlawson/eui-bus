require 'sinatra'
require 'bus'

# set :raise_errors => true
# set :show_exceptions => true
get '/' do
  "<!doctype html>
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
  <h1>Busses Near EUI</h1>
  <h2>From San Domenico</h2>
  <p>
    <a href='/sdsouth'>Bus 7 to Downtown</a><br />
    <a href='/sdnorth'>Bus 7 to Fiesole</a><br />
  </p>

  <h2>Near EUI Flats</h2>
  <p>
    <a href='/flats'>Bus 1A From Salviati to S.M.N.</a><br />
  </p>
  <h2>From Piazza San Marco</h2>
  <p>
    <a href='/sm7'>Bus 7 to EUI and Fiesole</a><br />
    <a href='/sm1'>Bus 1A/B to Lapo and Boccaccio</a><br />
  </p>

  <h2>From S.M.N. Train Station</h2>
  <p>
    <a href='/smn'>Bus 1A/B to Lapo and Boccaccio</a><br />
  </p>
  <h2>From Fiesole</h2>
  <p>
    <a href='/fiesole'>Bus 7 to San Domenico->San Marco</a>
  </p>
  <br /><br />
  <p><a href='about.html'>About</a> | <a href='http://temporealeataf.it/AVMFirenze/mobile/Home.htm'>ATAF Realtime</a> | <a href='http://www.ataf.net'>ATAF Home</a>
</body>
</html>"
end

get '/*' do
  @tabledata=getpage(params[:splat])
  erb :index
end
