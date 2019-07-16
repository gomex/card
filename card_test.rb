require 'minitest/autorun'
require_relative 'card'

class CardTest < Minitest::Test
  def test_above_limit
    # skip
    assert Card.abovelimit?("1000", "4000")
  end

  def test_not_above_limit
    # skip
    assert ! Card.abovelimit?("1000", "400")
  end

  def test_card_blocked
    # skip
    assert Card.cardblocked?("False")
  end
end
