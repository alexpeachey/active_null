class Post < ActiveRecord::Base
  extend ActiveNull
  has_many :comments
  null_model do
    def override
      'I am an override.'
    end
  end
end

class Comment < ActiveRecord::Base
  extend ActiveNull
  belongs_to :post
end

class NullPostDecorator < Draper::Decorator
  delegate_all
end

class PostDecorator < Draper::Decorator
  delegate_all
end
