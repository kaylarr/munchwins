require 'sinatra'
require 'pg'

require_relative './lib/fx'
require_relative './lib/character'
require_relative './lib/game'


layout = :'layouts/layout'

get '/' do
  erb :index, layout: layout
end

get '/game' do
  # Validate user and see if they have current game

  erb :'game/game', layout: layout, locals: {characters: Character.all}
end

post '/game/add' do
  sanitize(params)
  Character.new(params[:character_name], 1, params[:character_gender]).save
  redirect '/game'
end