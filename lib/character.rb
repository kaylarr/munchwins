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
end