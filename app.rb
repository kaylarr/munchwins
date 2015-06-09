require 'sinatra'
require 'pg'

require_relative './lib/database'
require_relative './lib/models/character'
require_relative './lib/models/game'


layout = :'layouts/layout'

USER = 1 # Get from session cookie eventually

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

  erb :'game/game', layout: layout, locals: {game: Game.from_id(USER)}
end



##### Set up a new game

post '/game/add' do
  sanitize(params)
  character = Character.new(params[:character_name], 1, params[:character_gender])
  Game.from_id(USER).save(character)
  redirect '/game'
end

get '/game/delete/:id' do
  sanitize(params)
  Game.from_id(USER).delete( Character.from_id(params[:id]) )
  redirect '/game'
end



##### Start game and display character cards

get '/game/play' do
  # game_state = 'cards'
  redirect '/game'
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
