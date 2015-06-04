require 'sinatra'
require 'pg'

layout = :'layouts/layout'

get '/' do
  erb :index, layout: layout
end