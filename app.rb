require 'sinatra'
require 'pg'

require_relative './lib/database'
require_relative './lib/models/game'
require_relative './lib/models/player'

layout = :'layouts/layout'

USER = 1
# Get from session cookie once OAuth set up
# Used in:
#  - Game#write_game_to_database


get '/' do
  # Show basic instructions with 'Vin Cheesel' sample card
  # Link to start game, or resume game if user has one open
  #  - Only allow one open game?
  erb :index, layout: layout
end

get '/game' do
  erb :'game/game', layout: layout, locals: {game: Game.from_id(USER)}
end

get '/game/new' do
  # Will this be redundany when USER is more dynamic?
  erb :'game/game', layout: layout, locals: {game: Game.new(USER)}
end

get '/game/add' do
  # Return to player setup from current game
  game = Game.from_id(USER)
  game.state = 'start'
  redirect '/game'
end

post '/game/add' do
  sanitize(params)
  player = Player.new(params[:player])
  Game.from_id(USER).create(player)
  redirect '/game'
end

get '/game/play' do
  # Return to scores page from game setup
  
  # Validate user and see if they have current game
  # link to /game/:id
  # sanitize(params)
  # pull from game_id = params[:id]

  game = Game.from_id(USER)
  game.state = 'scores'
  redirect '/game'
end




get '/game/delete/:id' do
  sanitize(params)
  Game.delete( Player.from_id(params[:id]) )
  redirect '/game'
end

# ##### Start game and display character cards


# get '/char/:id/up' do
#   sanitize(params)
#   Character.from_id(params[:id]).level_up
#   redirect '/game'
# end

# get '/char/:id/down' do
#   sanitize(params)
#   Character.from_id(params[:id]).level_down
#   redirect '/game'
# end



# ##### Switch to combat helper

# # game_state = 'combat'



# ##### Game finished

# # game_state = 'finished'
