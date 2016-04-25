require 'spec_helper'

describe ActiveNull do
  it 'defines the null class only when accessing it for the first time (ie: with a .null or .null_class call)' do
    expect(Object.const_defined? 'NullPost').to be_falsey
    expect(Object.const_defined? 'NullMicroPost').to be_falsey
    expect(Post.null).to be_instance_of NullPost
    expect(MicroPost.null_class).to eq NullMicroPost
    expect(Object.const_defined? 'NullPost').to be_truthy
    expect(Object.const_defined? 'NullMicroPost').to be_truthy
    expect(Test::TestModel.null).to be_instance_of Test::NullTestModel
  end

  describe '.null_class' do
    specify { expect(MicroPost.null_class).to eq NullMicroPost }
  end

  describe '.null' do
    specify { expect(Post.null).to be_instance_of(NullPost) }
    specify { expect(MicroPost.null).to be_instance_of(NullMicroPost) }
    specify { expect(Test::TestModel.null).to be_instance_of(Test::NullTestModel) }
  end

  describe '.null_model' do
    specify { expect(Post.null.override).to eq 'I am an override.' }
  end

  describe '.find_by' do
    specify { expect(Test::TestModel.find_by(id: 42)).to be_instance_of(Test::NullTestModel) }
  end

  describe 'a has many' do
    specify { expect(Post.null.comments).to eq [] }
    specify { expect(Post.null.comments).to be_instance_of(Comment::ActiveRecord_Relation) }
    specify { expect(MicroPost.null.comments).to eq [] }
    specify { expect(MicroPost.null.comments).to be_instance_of(Comment::ActiveRecord_Relation) }
  end

  describe 'a belongs to' do
    specify { expect(Comment.null.post).to be_instance_of(NullPost) }
    specify { expect(Comment.new.post).to be_instance_of(NullPost) }
    specify { expect(Comment.null.author).to be_instance_of(NullUser) }
    specify { expect(Comment.new.author).to be_instance_of(NullUser) }
  end

  it 'supports draper' do
    expect(Post.null.decorate).to be_decorated_with(NullPostDecorator)
  end
end
