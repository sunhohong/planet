require 'test_helper'
require 'lab/lang/module_lab'

class ModuleTest < ActiveSupport::TestCase
  test "test work" do
    assert_not_nil true
  end

  test "class and module" do
    s = Sequence.new(1, 10, 2)
    s.fromtoby do |x|
      puts x
    end

    assert_not_nil s
  end
end
