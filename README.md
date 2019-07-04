module-mixy
===========

`Module.mixy` is an imitation of `Module.mix`.

[![Build Status](https://secure.travis-ci.org/kachick/module-mixy.png)](http://travis-ci.org/kachick/module-mixy)
[![Gem Version](https://badge.fury.io/rb/module-mixy.png)](http://badge.fury.io/rb/module-mixy)

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

Install
-------

```bash
$ gem install module-mixy
```

Link
----

* [Home](http://kachick.github.com/module-mixy)
* [code](https://github.com/kachick/module-mixy)
* [API](http://www.rubydoc.info/github/kachick/module-mixy)
* [issues](https://github.com/kachick/module-mixy/issues)
* [CI](http://travis-ci.org/#!/kachick/module-mixy)
* [gem](https://rubygems.org/gems/module-mixy)

License
--------

The MIT X11 License  
Copyright (c) 2012 Kenichi Kamiya  
See MIT-LICENSE for further details.
