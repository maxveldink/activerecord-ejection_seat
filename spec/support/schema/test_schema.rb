# typed: false
# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :schema_info, force: :cascade do |t|
    t.integer :version, unique: true
  end
  SchemaInfo.create version: SchemaInfo::VERSION

  create_table :users, force: :cascade do |t|
    t.string :name
    t.integer :age
  end

  create_table :posts, force: :cascade do |t|
    t.string :title
    t.string :status
  end

  create_table :locations, force: :cascade do |t|
    t.string :name
  end
end
