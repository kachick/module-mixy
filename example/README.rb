# coding: us-ascii

$VERBOSE = true

require_relative '../lib/module/mixy'

module Foo
  def common
    'FOO :)'
  end
end

module Bar
  def common
    'bar :('
  end
end

class FooBar
  mixy Foo, :common => :foo_common
  mixy Bar, :common => :bar_common
end

foobar = FooBar.new
p foobar.methods.grep(/common/) #=> [:bar_common, :foo_common]
p foobar.foo_common             #=> "FOO :)"
p foobar.bar_common             #=> "bar :("
