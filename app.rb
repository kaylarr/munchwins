require 'sinatra'
require 'pg'

require 'net/http'
require 'net/https'
require 'cgi'
require 'json'

require_relative './lib/database'
require_relative './lib/models/game'
require_relative './lib/models/player'

enable :sessions
layout = :'layouts/layout'

USER = 1
# Get from session cookie once OAuth set up?

# Show basic instructions with 'Vin Cheesel' sample card?

get '/' do
  if session[:oauth][:access_token].nil?
    erb :start
  erb :index, layout: layout
end

# Incorporate '/game/:user_id' routes
get '/game' do
  erb :'game/game', layout: layout, locals: {game: Game.from_id(USER)}
end

get '/game/new' do
  # Will this be redundant when USER is more dynamic?
  erb :'game/game', layout: layout, locals: {game: Game.new(USER)}
end

get '/game/add' do
  # Return to player setup
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

get '/game/scores' do
  # Return to scores page
  
  # link to /game/:id
  # sanitize(params)
  # pull from game_id = params[:id]

  game = Game.from_id(USER)
  game.state = 'scores'
  redirect '/game'
end

# Game support routes

get '/game/delete/:id' do
  sanitize(params)
  Game.delete( Player.from_id(params[:id]) )
  redirect '/game'
end

# Character support routes

get '/player/:id/up' do
  sanitize(params)
  Player.from_id(params[:id]).level_up
  redirect '/game'
end

get '/player/:id/down' do
  sanitize(params)
  Player.from_id(params[:id]).level_down
  redirect '/game'
end

get '/player/:id/sexchange' do
  sanitize(params)
  Player.from_id(params[:id]).change_sex
  redirect '/game'
end

