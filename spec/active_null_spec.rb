require 'spec_helper'

describe ActiveNull do
  describe '.null' do
    specify { expect(Post.null).to be_instance_of(NullPost) }
  end

  describe '.null_model' do
    specify { expect(Post.null.override).to eq 'I am an override.' }
  end

  describe 'a has many' do
    specify { expect(Post.null.comments).to eq [] }
    specify { expect(Post.null.comments).to be_instance_of(Comment::ActiveRecord_Relation) }
  end

  describe 'a belongs to' do
    specify { expect(Comment.null.post).to be_instance_of(NullPost) }
    specify { expect(Comment.new.post).to be_instance_of(NullPost) }
  end

  it 'supports draper' do
    expect(Post.null.decorate).to be_decorated_with(NullPostDecorator)
  end
end
