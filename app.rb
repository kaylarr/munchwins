require 'sinatra'
require 'pg'

require_relative './lib/database'
require_relative './lib/models/character'
require_relative './lib/models/game'


layout = :'layouts/layout'

USER_ID = 1 # Get from session cookie..?

get '/' do
  # Show basic instructions with 'Vin Cheesel' sample card

  # Link to start game, or resume game if user has one open

  erb :index, layout: layout
end

get '/game' do
  # Validate user and see if they have current game
  # link to /game/:id
  # sanitize(params)
  # pull from game_id = params[:id]

  erb :'game/game', layout: layout, locals: {characters: Character.all}
end



##### Set up a new game

post '/game/add' do
  sanitize(params)
  Character.new(params[:character_name], 1, params[:character_gender]).save
  redirect '/game'
end

get '/game/delete/:id' do
  sanitize(params)
  Character.delete(params[:id])
  redirect '/game'
end



##### Start game and display character cards

get '/game/play' do
  # game_state = 'cards'
end

get '/char/:id/up' do
  sanitize(params)
  Character.from_id(params[:id]).level_up
  redirect '/game'
end

get '/char/:id/down' do
  sanitize(params)
  Character.from_id(params[:id]).level_down
  redirect '/game'
end



##### Switch to combat helper

# game_state = 'combat'



##### Game finished

# game_state = 'finished'
