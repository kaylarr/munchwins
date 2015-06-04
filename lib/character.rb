class Character
  attr_reader :name, :gender, :level

  def initialize(name, gender)
    @name = name
    @gender = gender
    @level = 1
  end

  def level_up
    @level += 1
  end

  def level_down
    @level -= 1 unless level == 1
  end

  def sex_change
    if @gender == 'male'
      @gender == 'female'
    else
      @gender == 'male'
    end
  end

  def roll
    rand(6) + 1
  end
end