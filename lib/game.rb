class Game
  def initialize
    @players = []
  end

  def add_player(name, gender)
    @players << Character.new(name, gender)
  end
end