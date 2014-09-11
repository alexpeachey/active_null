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
  null_model
end

class Comment < ActiveRecord::Base
  extend ActiveNull
  belongs_to :post
  null_model
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
    null_model
  end
end
