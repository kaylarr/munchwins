require_relative '../../../lib/models/character'

describe Character do

  let (:char) {Character.new('Vin Cheesel', 1, 'male')}
  
  context 'LEVELING' do

    describe '#level_up' do
      it 'increases in level to 2' do
        char.level_up
        expect(char.level).to eq 2
      end
    end

    describe '#level_down' do
      it 'decreases in level from 2 to 1' do
        char.level_up
        char.level_down
        expect(char.level).to eq 1
      end

      it 'stays at level 1' do
        char.level_down
        expect(char.level).to eq 1
      end
    end

    describe '#update_level' do
      it 'successfully updates level' do
        expect(char.level_up).to eq 'Vin Cheesel has risen to level 2!'
      end
    end
  end

  context 'STATUS CHANGES' do

    describe '#change_sex' do
      it 'changes from male to female' do
        char.change_sex
        expect(char.gender).to eq 'female'
      end

      it 'changes from female to male' do
        char.change_sex
        char.change_sex
        expect(char.gender).to eq 'male'
      end
    end

    describe '#update_sex' do
      it 'successfully updates gender' do
        expect(char.change_sex).to eq 'Vin Cheesel becomes a female!'
      end
    end
  end

  context 'PERFORMING ACTIONS' do

    describe '::roll' do
      it 'gives value >= 1' do
        expect(Character.roll).to be >= 1
      end

      it 'gives value <= 6' do
        expect(Character.roll).to be <= 6
      end
    end
  end
end
