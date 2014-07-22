ActiveRecord::Schema.define do
  self.verbose = false

  create_table :posts, force: true do |t|
    t.string :title
    t.timestamps
  end

  create_table :comments, force: true do |t|
    t.string :content
    t.references :post
    t.timestamps
  end
end
