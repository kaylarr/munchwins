class Character
  attr_reader :name, :gender, :level

  def initialize(name, gender)
    @name = name
    @gender = gender
    @level = 1
    save_char
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

  def roll
    rand(6) + 1
  end

  private

  def save_char
    # Write char to database
    true
  end

  def get_id
    exec("SELECT id FROM characters WHERE ")
  end

  def update_level
    # exec("UPDATE characters SET level = #{@level}
    #   WHERE id = #{@id}")
    true
  end

  def update_sex
    # exec("UPDATE characters SET gender = '#{@gender}'
    #   WHERE id = #{@id}")
    true
  end

end
