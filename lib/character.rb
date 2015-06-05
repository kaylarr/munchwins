class Character
  attr_reader :name
  attr_reader :level
  attr_reader :gender
  attr_reader :id

  def initialize(name, level, gender)
    @name = name
    @gender = gender
    @level = level

    @id = exec("SELECT id FROM characters WHERE name = #{@name}")
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

  def save
    exec_params("INSERT INTO characters (name, level, gender_id) VALUES ($1, $2, $3)",
      [@name, @level, get_gender_id(@gender)])
    true
  end

  class << self
    
    def all
      # Get all characters from database
      exec("
        SELECT characters.name, characters.level, genders.gender 
        FROM characters JOIN genders ON characters.gender_id = genders.id
        ").each_with_object([]) do |hash, arr|
            arr << Character.parse(hash)
          end
    end

    def parse(hash)
      Character.new(hash["name"], hash["level"], hash["gender"])
    end

    def roll
      rand(6) + 1
    end
  end

  def get_gender_id(gender)
    exec_params("SELECT id FROM genders WHERE gender = $1", [gender]).first["id"]
  end

  private

  def update_level
    # exec("UPDATE characters SET level = #{@level}
    #   WHERE game_id = ##### AND name = '#{@name}'")
    true
  end

  def update_sex
    # exec("UPDATE characters SET gender = '#{@gender}'
    #   WHERE game_id = ##### AND name = '#{@name}'")
    true
  end

end
