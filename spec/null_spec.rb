require 'spec_helper'

describe 'Null Models' do
  subject(:null_model) { Test::TestModel.null }

  describe '#nil?' do
    specify { expect(null_model.nil?).to be_truthy }
  end

  describe '#present?' do
    specify { expect(null_model.present?).to be_falsey }
  end

  describe '#blank?' do
    specify { expect(null_model.blank?).to be_truthy }
  end

  describe '#to_json' do
    specify { expect(null_model.to_json).to eq '{}' }
  end

  context 'Decoratable Null Models' do
    subject(:null_model) { Post.null }

    describe '#decorate' do
      specify { expect(null_model.decorate).to be_decorated_with(null_model.decorator_class) }
    end

    describe '#decorator_class?' do
      specify { expect(null_model.decorator_class?).to eq NullPostDecorator }
    end

    describe '#decorator_class' do
      specify { expect(null_model.decorator_class).to eq NullPostDecorator }
    end

    context 'when not yet decorated' do
      describe '#decorated?' do
        specify { expect(null_model.decorated?).to be_falsey }
      end

      describe '#decorated_with?' do
        specify { expect(null_model.decorated_with?(null_model.decorator_class)).to be_falsey }
      end

      describe '#applied_decorators' do
        specify { expect(null_model.applied_decorators).to eq [] }
      end
    end

    context 'when decorated' do
      subject(:null_model) { Post.null.decorate }

      describe '#decorated?' do
        specify { expect(null_model.decorated?).to be_truthy }
      end

      describe '#decorated_with?' do
        specify { expect(null_model.decorated_with?(null_model.decorator_class)).to be_truthy }
      end

      describe '#applied_decorators' do
        specify { expect(null_model.applied_decorators).to eq [NullPostDecorator] }
      end
    end
  end
end
