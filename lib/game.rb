class Game
  def initialize
    @players = []
  end

  def add_player(name, gender='male')
    @players << Character.new(name, gender)
  end
end