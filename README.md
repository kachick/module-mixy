module-mixy
===========

* ***This repository is archived***
* ***No longer maintained***
* ***All versions have been yanked from https://rubygems.org for releasing valuable namespace for others***


`Module.mixy` is an imitation of `Module.mix`.

Features
--------

* Pure Ruby :)

Usage
-----

### Overview

```ruby
require 'module/mixy'

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
  extend Module::Mixy
  mixy Foo, :common => :foo_common
  mixy Bar, :common => :bar_common
end

foobar = FooBar.new
p foobar.methods.grep(/common/) #=> [:bar_common, :foo_common]
p foobar.foo_common             #=> "FOO :)"
p foobar.bar_common             #=> "bar :("
```

### Be anywhere

```ruby
require 'module/mixy/core_ext'
```

Requirements
-------------

* [Ruby 2.5 or later](http://travis-ci.org/#!/kachick/module-mixy)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.
