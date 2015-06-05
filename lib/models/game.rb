class Game
  def initialize
    @players = []
    @log = []
  end

  def add_player(name, gender='male')
    @players << Character.new(name, gender)
  end

  def log(action)
    @log << "#{action}\n"
  end
end