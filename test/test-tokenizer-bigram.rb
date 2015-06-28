# coding: utf-8

require "sakuru/tokenizer/bigram"

class TokenizerBigramTest < Test::Unit::TestCase
  def setup
    @tokenizer = Sakuru::Tokenizer::Bigram
  end

  def test_ascii
    assert_equal(["th", "he"],
                 @tokenizer.tokenize("the"))
  end

  def test_one_character
    # TODO
    assert_equal([],
                 @tokenizer.tokenize("あ"))
  end

  def test_two_character
    assert_equal(["あい"],
                 @tokenizer.tokenize("あい"))
  end

  def test_three_character
    assert_equal(["あい", "いう"],
                 @tokenizer.tokenize("あいう"))
  end
end
