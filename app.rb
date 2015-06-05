require 'sinatra'
require 'pg'

require_relative './lib/fx'
require_relative './lib/character'
require_relative './lib/game'


layout = :'layouts/layout'

get '/' do
  erb :index, layout: layout
end

get '/start' do
  "Start a new game"
end