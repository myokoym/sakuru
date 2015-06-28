module Sakuru
  module Tokenizer
    class Bigram
      class << self
        def tokenize(text)
          tokens = text.split(//).each_cons(2)
          if block_given?
            tokens.each do |chars|
              yield chars.join
            end
          else
            tokens.collect do |chars|
              chars.join
            end
          end
        end
      end
    end
  end
end
