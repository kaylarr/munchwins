class User
  # Update name from Facebook on each login

  attr_reader :id, :name

  class << self

    def create(uid, name)
      User.new({
        id: exec_params("INSERT INTO users (uid, name) VALUES ($1, $2) RETURNING id", [uid, name]),
        name: name
        })
    end

    def from_uid(uid)
      User.new(
        exec_params("SELECT id, name FROM users WHERE uid = $1", [uid]).first
      )
    end

    def exist?(uid)
      exec_params( "SELECT COUNT(*) FROM users WHERE uid = $1", [uid] ).first["count"] == '1'
    end

    def get_id(uid)
      exec_params( "SELECT id, name FROM users WHERE uid = $1", [uid] ).first["id"]
    end

    def open_game?(user_id)
      exec_params("
        SELECT COUNT(*) FROM games WHERE user_id = $1 AND game_state_id < 4",
        [user_id]
      ).first["count"] == '1'
    end

  end # class << self

  def initialize(params = {})
    @id = params.fetch("id", nil)
    @name = params.fetch("name", nil)
  end
end