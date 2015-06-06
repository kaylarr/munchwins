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
      Game.new(hash["state"])
    end
  end

  ### INSTANCE METHODS

  def initialize(state)
    # @date = @date || Time.now.to_s.slice(0..9)
    @state = state
  end

  def add_characters
    nil
  end

  def character

  end

  def logs

  end

  def timestamp
    "(timestamp)"
  end

  def log(action)
    @log << "<#{timestamp}> #{action}\n"
  end

  private

  # What calls need to be private?
end