$VERBOSE = true

require_relative '../lib/module/mixy'

# @see http://www.rubyist.net/~matz/20101113.html

module American
  attr_reader :address
end

module Japanese
  attr_reader :address
end

class JapaneseAmerican
  #mixy American
  #mixy Japanese  #=> [address] conflicts (Module::ConflictError)

  mixy American, :address => :us_address
  mixy Japanese, :address => :jp_address
end

p JapaneseAmerican.new.methods.grep(/address/) #=> [:jp_address, :us_address]

