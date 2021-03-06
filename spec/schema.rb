ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, force: true do |t|
    t.string :title
    t.string :_type
    t.timestamps null: true
  end

  create_table :users, force: true do |t|
    t.string :name
    t.timestamps null: true
  end

  create_table :comments, force: true do |t|
    t.string :content
    t.references :post
    t.references :author, polymorphic: true
    t.timestamps null: true
  end

  create_table :test_models, force: true do |t|
    t.timestamps null: true
  end
end
