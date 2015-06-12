require 'sinatra'
require 'pg'

require 'omniauth-facebook'

require_relative './config/vars'

require_relative './lib/database'
require_relative './lib/models/game'
require_relative './lib/models/player'

enable :sessions

use OmniAuth::Builder do
  provider :facebook, ENV["FB_ID"] || FB_ID, ENV["FB_SECRET"] || FB_SECRET
end

layout = :'layouts/layout'

USER = 1

# FACEBOOK authentication
# Use:
#   env['omniauth.auth']['info']['name']
#   env['omniauth.auth']['info']['image']
#   env['omniauth.auth']['uid']
#   "#{env['omniauth.auth']}"
#   session[:username] = env['omniauth.auth']['info']['name']
#   session[:uid] = env['omniauth.auth']['uid']

get '/login' do
  redirect to('/auth/facebook')
end

get '/auth/facebook/callback' do
  # Create new USER based off of uid,
  # use user_id from table in sessions?

  env['omniauth.auth'] ? session[:admin] = true : halt(401, 'Not Authorized')
  session[:username] = env['omniauth.auth']['info']['name']
  session[:uid] = env['omniauth.auth']['uid']
  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end

get 'auth/failure' do
  params[:message]
end

# Show basic instructions with 'Vin Cheesel' sample card?

get '/' do

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

