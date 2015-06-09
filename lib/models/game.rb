class Game

  class << self
    def all(user)
      # Get all games for user
    end

    def from_id(id)
      Game.parse(
        exec_params("
          SELECT games.id, game_states.state
          FROM games JOIN game_states ON games.state_id = game_states.id
          WHERE games.id = $1", [id]
        ).first
      )
    end

    def parse(hash)
      Game.new(hash["id"], hash["state"])
    end
  end

  ### INSTANCE METHODS

  def initialize(id, state='start')
    # @date = @date || Time.now.to_s.slice(0..9) --> don't init with date, save with date?
    @id = id
    @state = state
  end

  # Attributes

  def state
    exec_params("
      SELECT games.id, game_states.state
      FROM games JOIN game_states ON games.state_id = game_states.id
      WHERE games.id = $1", [@id]
    ).first["state"]
  end

  # def state=(state)
  #   state_id = get_state_id(state)
  #   exec_params("
  #     UPDATE games SET state
  #     ")
  # end


  # Character interaction

  def characters
    Character.all#(id)
  end

  def save(character)
    # Incorporate game.id
    exec_params("INSERT INTO characters (name, level, gender_id) VALUES ($1, $2, $3)",
      [character.name, character.level, character.gender_id])
    true
  end

  def delete(character)
    # Incorporate game.id
    exec_params("DELETE FROM characters WHERE id = $1", [character.id])
  end

  # def logs

  # end

  # def timestamp
  #   "(timestamp)"
  # end

  # def log(action)
  #   @log << "<#{timestamp}> #{action}\n"
  # end

  private

  # What calls need to be private?
end