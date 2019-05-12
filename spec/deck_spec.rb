require 'deck'

module ArrayMatchers
  extend RSpec::Matchers::DSL

  matcher :be_contiguous_by do
    match do |array|
      !all_non_contiguous_pair(array)
    end

    failure_message do |array|
      message = ''
      all_non_contiguous_pair(array).each do |pair|
        message += "#{pair[0]} and #{pair[1]} were not contiguous\n"
      end
      message
    end

    description do
      'be contiguous'
    end

    def all_non_contiguous_pair(array)
      result = array
                 .sort_by(&block_arg)
                 .each_cons(2)
                 .reject { |x, y| block_arg.call(x) + 1 == block_arg.call(y) }

      result == [] ? nil : result
    end
  end
end

describe 'Deck' do
  include ArrayMatchers

  describe 'all' do
    it 'contains 32 cards' do
      expect(Deck.all.length).to eq 32
    end
  end

  it 'has a seven as its lowest card' do
    expect(Deck.all).to all(have_attributes(rank: be >= 7))
  end

  it 'has contiguous ranks bu suit' do
    expect(Deck.all.group_by(&:suit).values).to all(be_contiguous_by(&:rank))
  end
end
