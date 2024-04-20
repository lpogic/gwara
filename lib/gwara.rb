require 'modeling'
require 'koper'
require_relative 'gwara/lexer'
require_relative 'gwara/parser'

class Gwara
  model do
    @parser = Parser.new self
    @lexer = Lexer.new @parser
  end

  def <<(string)
    string.each_char do |ch|
      @lexer << ch
    end
  end

  def to_s
    @lexer.close
    @parser.close
  end
end