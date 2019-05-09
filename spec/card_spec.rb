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
    raise unless card(suit: :spades, rank: 4).suit == :spades
  end

  it 'has a rank' do
    raise unless card(suit: :spades, rank: 4).rank == 4
  end

  context 'equality' do
    subject { card(suit: :spades, rank: 4) }

    describe 'comparing against self' do
      let(:other) { card(suit: :spades, rank: 4) }

      it 'is equal to itself' do
        raise unless subject == other
      end

      it 'is hash equal to itself' do
        raise unless Set.new([subject, other]).size == 1
      end
    end

    shared_examples 'an unequal card' do
      it 'is not equal' do
        raise unless subject != other
      end

      it 'is not hash equal' do
        raise unless Set.new([subject, other]).size == 2
      end
    end

    describe 'comparing to a card of different suit' do
      let(:other) { card(suit: :heart, rank: 4) }

      it_behaves_like 'an unequal card'
    end

    describe 'comparing to a card of different rank' do
      let(:other) { card(suit: :spades, rank: 5) }

      it_behaves_like 'an unequal card'
    end
  end

  describe 'a jack' do
    let(:lower) { card(rank: 10) }
    let(:higher) { card(rank: :jack) }

    it 'ranks higher than a 10' do
      raise unless higher.rank > lower.rank
    end
  end

  describe 'a queen' do
    let(:lower) { card(rank: :jack) }
    let(:higher) { card(rank: :queen) }

    it 'ranks higher than a jack' do
      raise unless higher.rank > lower.rank
    end
  end

  describe 'a kink' do
    let(:lower) { card(rank: :queen) }
    let(:higher) { card(rank: :king) }

    it 'ranks higher than a queen' do
      raise unless higher.rank > lower.rank
    end
  end
end
