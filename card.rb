class Card
  attr_reader :suit, :rank

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
            when :jack then 11
            when :queen then 12
            when :king then 13
            else rank
            end
  end
end

RSpec.describe 'a playing card' do
  it 'has a suit' do
  end

  it 'has a rank' do
  end
end