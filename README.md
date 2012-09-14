module-mixy
===========

[![Build Status](https://secure.travis-ci.org/kachick/module-mixy.png)](http://travis-ci.org/kachick/module-mixy)

Description
-----------

Module.mixy is not Module.mix :)

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
  mixy Foo, :common => :foo_common
  mixy Bar, :common => :bar_common
end

foobar = FooBar.new
p foobar.methods.grep(/common/) #=> [:bar_common, :foo_common]
p foobar.foo_common             #=> "FOO :)"
p foobar.bar_common             #=> "bar :("
```

Requirements
-------------

* Ruby - [1.9.2 or later](http://travis-ci.org/#!/kachick/module-mixy)

Install
-------

```bash
$ gem install module-mixy
```

Link
----

* [code](https://github.com/kachick/module-mixy)
* [API](http://kachick.github.com/module-mixy/yard/frames.html)
* [issues](https://github.com/kachick/module-mixy/issues)
* [CI](http://travis-ci.org/#!/kachick/module-mixy)
* [gem](https://rubygems.org/gems/module-mixy)

License
--------

The MIT X11 License  
Copyright (C) 2012 Kenichi Kamiya  
See the file LICENSE for further details.

