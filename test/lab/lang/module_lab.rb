class LanguageLab

  def self.class_and_module
    s = Sequence.new(1, 10, 2)
    s.fromtoby do |x|
      puts s
    end
  end
end

class Sequence
  include Enumerable

  def initialize(from, to, by)
    @from, @to, @by = from, to, by
  end
end

module Sequences
  def fromtoby
    x = @from
    while x <= @to
      yield x
      x += @by
    end
  end
end
