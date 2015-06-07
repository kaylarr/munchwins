class Character
  attr_reader :name
  attr_reader :level
  attr_reader :gender
  attr_reader :id

  class << self
    
    def all#(game_id)
      # Incorporate game_id
      exec("
        SELECT characters.name, characters.level, genders.gender 
        FROM characters JOIN genders ON characters.gender_id = genders.id
        ").each_with_object([]) do |hash, arr|
            arr << Character.parse(hash)
          end.sort {|a, b| b.level <=> a.level}
    end

    def from_id(id)
      Character.parse(
        exec_params("
          SELECT characters.name, characters.level, genders.gender 
          FROM characters JOIN genders ON characters.gender_id = genders.id
          WHERE characters.id = $1", [id]
          ).first
      )
    end

    def parse(hash)
      Character.new(hash["name"], hash["level"].to_i, hash["gender"])
    end
  end



  ### INSTANCE METHODS

  def initialize(name, level, gender)
    @name = name
    @gender = gender
    @level = level
  end

  def id
    exec_params("SELECT id FROM characters WHERE name = $1", [@name]).first["id"]
  end



  # Attribute changes

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

  def gender_id
    exec_params("SELECT id FROM genders WHERE gender = $1", [@gender]).first["id"]
  end



  private

  def update_level
    exec_params("UPDATE characters SET level = $1
      WHERE name = $2", # Add game_id when incorporated
      [@level, @name])
    true
  end

  def update_sex
    # exec("UPDATE characters SET gender = '#{@gender}'
    #   WHERE game_id = ##### AND name = '#{@name}'")
    true
  end
end
