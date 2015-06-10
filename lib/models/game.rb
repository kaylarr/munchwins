class Game
  attr_reader :id, :state, :date

  class << self

    def all(user_id)
      exec_params("
        SELECT games.id, games.game_date AS date, game_states.state
        FROM games JOIN game_states ON games.game_state_id = game_states.id
        WHERE user_id = $1", [user_id]
        ).map {|hash| Game.new(user_id, hash)}
    end

    def from_id(user_id)
      Game.new(
        user_id,
        exec_params("
          SELECT games.id, games.game_date AS date, game_states.state
          FROM games JOIN game_states ON games.game_state_id = game_states.id
          WHERE games.user_id = $1 AND game_state_id < 4", [user_id]
        ).first
      )
    end

    def delete(player)
      exec_params("DELETE FROM players WHERE id = $1", [player.id])
    end

  end

  ### INSTANCE METHODS

  def initialize(user_id, params = {})
    @user_id = user_id
    @id =
      if params["id"].nil?  # New game
        write_game_and_return_id
      else  # Existing game
        params["id"]
      end
    @state = params.fetch("state", "start")
    @date = params.fetch("date", current_day)
  end

  def write_game_and_return_id
    exec_params("
      INSERT INTO games (game_date, game_state_id, user_id) VALUES ($1, $2, $3)
      RETURNING id", [current_day, 1, @user_id]
      ).first["id"]
  end

  def state=(state)
    @state = state
    exec_params("UPDATE games SET game_state_id = $1 WHERE id = $2",
      [state_id(state), @id])
  end

  # Player interaction

  def players
    Player.all(@id)
  end

  def create(player)
    exec_params("
      INSERT INTO players (
        name, level, gender_id, game_id, in_combat)
      VALUES ($1, $2, $3, $4, FALSE)",
      [player.name, player.level, player.gender_id, @id])
  end


  private

  def current_day
    Time.now.to_s.slice(0..9)
  end

  def state_id(state)
    exec_params("SELECT id FROM game_states WHERE state = $1", [state]).first["id"]
  end

  # def state
  #   exec_params("
  #     SELECT games.id, game_states.state
  #     FROM games JOIN game_states ON games.state_id = game_states.id
  #     WHERE games.id = $1", [@id]
  #   ).first["state"]
  # en
end