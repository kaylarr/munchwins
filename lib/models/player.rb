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
    @level = params.fetch("level", 1).to_i
    @gender = params.fetch("gender", "male")
    @id = params.fetch("id", nil)
  end

  def gender_id
    exec_params("SELECT id FROM genders WHERE gender = $1", [@gender]).first["id"]
  end

  # Player behaviors
  # Return strings for game.log

  def level_up
    @level += 1
    if update_level
      "#{@name} has risen to level #{@level}!"
    else # handle error
    end
  end

  def level_down
    if @level > 1
      @level -= 1
      if update_level
        "#{@name} has dropped to level #{@level}."
      else # handle error
      end
    else
      "#{name} barely remains at level 1..."
    end
  end

  def change_sex
    if @gender == 'male'
      @gender = 'female'
    else
      @gender = 'male'
    end
    if update_sex
      "#{@name} becomes a #{@gender}!"
    else # handle error
    end
  end

  private

  def update_level
    # Incorporate error handling - true if update, else false
    exec_params("UPDATE players SET level = $1 WHERE id = $2",
      [@level, @id])
    true
  end

  def update_sex
    # Incorporate error handling - true if update, else false
    exec_params("UPDATE players SET gender_id = $1 WHERE id = $2",
      [gender_id(@gender), @id])
    true
  end

  def gender_id(gender)
    exec_params("SELECT id FROM genders WHERE gender = $1", [gender]).first["id"]
  end
end