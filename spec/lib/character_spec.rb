require_relative '../../lib/character'

describe Character do

  context 'leveling' do
    
    let (:char) {Character.new('Flighter', 'male')}

    describe '#level_up' do
      it 'increases in level to 2' do
        char.level_up
        expect(char.level).to eq 2
      end
    end

    describe '#level_down' do
      it 'decreases in level from 2 to 1' do
        char.level_down
        expect(char.level).to eq 1
      end

      it 'stays at level 1' do
        char.level_down
        expect(char.level).to eq 1
      end
    end

  end

  describe '#sex_change' do

  end

  describe '#roll' do

  end

end
