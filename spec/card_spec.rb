require 'set'
require 'card'

describe 'a playing card' do
  def card(params = {})
    default = {
      suit: :heart,
      rank: 7
    }

    Card.build(*default.merge(params).values_at(:suit, :rank))
  end

  it 'has a suit' do
    expect(card(suit: :spades, rank: 4).suit).to eq :spades
  end

  it 'has a rank' do
    expect(card(suit: :spades, rank: 4).rank).to eq 4
  end

  context 'equality' do
    subject { card(suit: :spades, rank: 4) }

    describe 'comparing against self' do
      let(:another) { card(suit: :spades, rank: 4) }
      let(:set) { Set.new([subject, another]) }

      it 'is equal to itself' do
        expect(subject).to eq another
      end

      it 'is hash equal to itself' do
        expect(set.size).to eq 1
      end
    end

    shared_examples 'an unequal card' do
      let(:set) { Set.new([subject, another]) }

      it 'is not equal' do
        expect(subject).not_to eq another
      end

      it 'is not hash equal' do
        expect(set.size).to eq 2
      end
    end

    describe 'comparing to a card of different suit' do
      let(:another) { card(suit: :heart, rank: 4) }

      it_behaves_like 'an unequal card'
    end

    describe 'comparing to a card of different rank' do
      let(:another) { card(suit: :spades, rank: 5) }

      it_behaves_like 'an unequal card'
    end
  end

  describe 'a jack' do
    let(:lower) { card(rank: 10) }
    let(:higher) { card(rank: :jack) }

    it 'ranks higher than a 10' do
      expect(higher.rank).to be > lower.rank
    end
  end

  describe 'a queen' do
    let(:lower) { card(rank: :jack) }
    let(:higher) { card(rank: :queen) }

    it 'ranks higher than a jack' do
      expect(higher.rank).to be > lower.rank
    end
  end

  describe 'a kink' do
    let(:lower) { card(rank: :queen) }
    let(:higher) { card(rank: :king) }

    it 'ranks higher than a queen' do
      expect(higher.rank).to be > lower.rank
    end
  end
end
