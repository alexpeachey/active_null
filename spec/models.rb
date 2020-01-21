class Post < ActiveRecord::Base
  extend ActiveNull
  has_many :comments
  null_model do
    def override
      'I am an override.'
    end
  end
end

class MicroPost < Post
  extend ActiveNull
end

class User < ActiveRecord::Base
  extend ActiveNull
  has_many :comments, as: :author

  null_model(:guest)
end

class Comment < ActiveRecord::Base
  extend ActiveNull
  belongs_to :post
  belongs_to :author, polymorphic: true
  null_defaults_for_polymorphic author: 'User'
end

class NullPostDecorator < Draper::Decorator
  delegate_all
end

class PostDecorator < Draper::Decorator
  delegate_all
end

module Test
  class TestModel < ActiveRecord::Base
    extend ActiveNull
  end
end
