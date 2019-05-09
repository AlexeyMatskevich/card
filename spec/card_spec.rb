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
    def subject
      @subject ||= card(suit: :spades, rank: 4)
    end

    def other
      @other ||= card(suit: :spades, rank: 4)
    end

    it 'is equal to itself' do
      raise unless subject == other
    end

    it 'is hash equal to itself' do
      raise unless Set.new([subject, other]).size == 1
    end

    describe 'comparing to a card of different suit' do
      def other
        @other ||= card(suit: :heart, rank: 4)
      end

      it 'is not equal' do
        raise unless subject != other
      end

      it 'is not hash equal' do
        raise unless Set.new([subject, other]).size == 2
      end
    end

    describe 'comparing to a card of different rank' do
      def other
        @other ||= card(suit: :spades, rank: 5)
      end

      it 'is not equal to a card of differing rank' do
        raise unless subject != other
      end

      it 'is not hash equal to a card of differing rank' do
        raise unless Set.new([subject, other]).size == 2
      end
    end
  end

  describe 'a jack' do
    it 'ranks higher than a 10' do
      lower  = card(rank: 10)
      higher = card(rank: :jack)

      raise unless higher.rank > lower.rank
    end
  end

  describe 'a queen' do
    it 'ranks higher than a jack' do
      lower  = card(rank: :jack)
      higher = card(rank: :queen)

      raise unless higher.rank > lower.rank
    end
  end

  describe 'a kink' do
    it 'ranks higher than a queen' do
      lower  = card(rank: :queen)
      higher = card(rank: :king)

      raise unless higher.rank > lower.rank
    end
  end
end
