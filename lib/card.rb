class Card
  attr_reader :suit, :rank

  def self.build(suit, rank)
    new(suit: suit, rank: rank)
  end

  private_class_method :new

  def initialize(suit:, rank:)
    @suit = suit
    @rank = case rank
            when :jack then
              11
            when :queen then
              12
            when :king then
              13
            when :ace then
              14
            else
              rank
            end
  end

  def inspect
    to_s
  end

  def to_s
    (rank_to_s + suit_to_s).to_s
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def hash
    [rank, suit].hash
  end

  def eql?(other)
    self == other
  end

  def to_json(*_args)
    {
      rank: rank,
      suit: suit
    }.to_json
  end

  def self.from_sting(value)
    short_suit = value[-1]

    suit = {
      'H' => :hearts,
      'D' => :diamonds,
      'S' => :spades,
      'C' => :clubs
    }.fetch(short_suit)

    rank = {
      'A' => :ace,
      'K' => :king,
      'Q' => :queen,
      'J' => :jack
    }.fetch(value[0]) { value[0..-2].to_i }

    Card.build(suit, rank)
  end

  private

  def rank_to_s
    if @rank.instance_of?(Integer)
      @rank.to_s
    else
      @rank.to_s[0].upcase
    end
  end

  def suit_to_s
    case @suit
    when :hearts then
      "\xE2\x99\xA5"
    when :clubs then
      "\xE2\x99\xA3"
    when :diamonds then
      "\xE2\x99\xA6"
    when :spades then
      "\xE2\x99\xA0"
    else
      @suit.to_s
    end
  end
end
