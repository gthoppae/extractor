require 'rubygems'
require 'sinatra'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  #enable :sessions
end

get '/' do
  erb :home
end

get '/extract/nonsyn' do
  #puts exec('grep "nonsyn"' + Dir.pwd + "/../cows.chr6.target.vars.flt.ann.EffOnePerLine.txt")
  output = IO.popen("grep 'NON_SYN' /Users/vidhya/dev/cows.chr6.target.vars.flt.ann.EffOnePerLine.txt").readlines

	## HTML representation
  #r = '<table border="1">'
  #h = '<tr><th>chr</th><th>pos</th></tr>'
  #r += h
  #output.each { |o|
  #  r += "<tr>" + o.split(' ').collect { |s| s.split('\t').collect { "<td>#{s}</td>"}.join(' ') }.join(' ') + "<tr>"
  #}
  #r += "</table>"

	## CSV representation
  r = ""
  output.each { |o|
    r += o.split('\t').join(' ')
  }
  
	if params.keys.index('csv')
	headers "Content-Disposition" => "attachment;filename='nonsyn.csv'", "Content-Type" => "application/csv"
	return r
	else 
	headers "Content-Type" => "text/plain"
	return r
	end
  #erb r

end

get '/extract/range' do

	output=IO.popen("cat /Users/vidhya/dev/cows.chr6.target.vars.flt.ann.EffOnePerLine.txt | awk '$2 > 104900274 {print}' | awk '$2 < 104903354 {print}'").readlines
	r = ""
  	output.each { |o|
    	r += o.split('\t').join(' ') 
	}

	headers "Content-Type" => "text/plain"
	return r 

	#erb r
end

#post '/extract/range' do
#end

get '/hello' do
  @error = "yeeks"
  erb :hello
end

