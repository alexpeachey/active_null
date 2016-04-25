[![Circle CI](https://circleci.com/gh/Originate/active_null.svg?style=shield)](https://circleci.com/gh/Originate/active_null)
[![Coverage Status](https://coveralls.io/repos/Originate/active_null/badge.svg?branch=master&service=github)](https://coveralls.io/github/Originate/active_null?branch=master)
[![Code Climate](https://codeclimate.com/github/Originate/active_null/badges/gpa.svg)](https://codeclimate.com/github/Originate/active_null)

# ActiveNull

Using Null Objects can make life a lot easier and avoid having excessive `nil?` checks.
Avdi Grimm made an excellent library called [Naught][1] which makes
working with and building Null Objects easier. Thank you Avdi for making
this possible!

This library makes ActiveRecord Models aware of Null Objects and act as you
would hope they would when using null objects in your project.

This is specially useful when combined with a decorator library like [Draper][2].
By knowing you have an object instead of the dreaded `nil` you can just
decorate it and your view won't know any different.

## Installation

Add this line to your application's Gemfile:

    gem 'active_null'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_null

## Usage

For each model you would like to be null aware, `extend ActiveNull`.

```ruby
class Post < ActiveRecord::Base
  extend ActiveNull
  has_many :comments
end

class Comment < ActiveRecord::Base
  extend ActiveNull
  belongs_to :post
end
```

You can now do things like this:

```ruby
Post.null              # => <null:Post>
Post.null.comments     # => <ActiveRecord::Relation []>
Comment.null           # => <null:Comment>
Comment.null.post      # => <null:Post>
Comment.new.post       # => <null:Post>
Post.find_by(id: 1)    # => <null:Post>
```

## Additional Features

You may find you want your Null Object to respond to certain methods
in a specific way. These methods might be new or they might be
overrides of the default Null Object definition.
You can define this in your model:

```ruby
class Post < ActiveRecord::Base
  extend ActiveNull

  null_model do
    def some_method
      # special functionality
    end
  end
end
```

When using polymorphic relationships, ActiveNull must be told a default
model to use for the Null Object representation.

```ruby
class Post < ActiveRecord::Base
  extend ActiveNull
  belongs_to :author, polymorphic: true
  null_defaults_for_polymorphic author: 'User'
end
```

If you have `Draper` included in your project, the Null Object versions of
your model will respond as expected to `decorate`.

You can then safely do something like:

```ruby
@post = Post.find_by(id: 1).decorate
```

## Contributing

1. Fork it ( https://github.com/Originate/active_null/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


  [1]: https://github.com/avdi/naught
  [2]: https://github.com/drapergem/draper
