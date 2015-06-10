class Player

  attr_reader :name, :level, :gender, :id

  class << self
    
    def all(game_id)
      exec_params("
        SELECT players.name, players.level, players.id AS id, genders.gender 
        FROM players JOIN genders ON players.gender_id = genders.id
        WHERE game_id = $1", [game_id]
        ).each_with_object([]) do |hash, arr|
            arr << Player.new(hash)
          end.sort {|a, b| b.level <=> a.level}
    end

    def from_id(player_id)
      Player.new(
        exec_params("
          SELECT players.name, players.level, players.id AS id, genders.gender 
          FROM players JOIN genders ON players.gender_id = genders.id
          WHERE players.id = $1", [player_id]
          ).first
      )
    end

  end # class << self

  def initialize(params = {})
    @name = params.fetch("name", "Player")
    @level = params.fetch("level", 1)
    @gender = params.fetch("gender", "male")
    @id = params.fetch("id", nil)
  end

  def gender_id
    exec_params("SELECT id FROM genders WHERE gender = $1", [@gender]).first["id"]
  end
end