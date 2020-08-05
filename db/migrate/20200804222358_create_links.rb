class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.timestamps
      t.text :url, null: false
      t.text :description
      t.text :slug, null: false
      t.datetime :first_used_at
      t.datetime :last_used_at
      t.bigint :uses_count, default: 0

      t.index :url
      t.index :slug, unique: true
    end
  end
end
