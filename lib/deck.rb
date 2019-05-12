require 'card'

class Deck
  # All ranks, from 7 to ace
  RANKS = (7..10).to_a + %i[jack queen king ace]

  # All four suits
  SUITS = %i[hearts clubs diamonds spades].freeze

  # For every suit next to every rank
  def self.all
    SUITS.product(RANKS).map do |suit, rank|
      Card.build(suit, rank)
    end
  end
end
