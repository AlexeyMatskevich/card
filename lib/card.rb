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
